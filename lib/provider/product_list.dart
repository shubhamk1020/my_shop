import 'package:flutter/material.dart';
import 'package:my_shop/Model/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'Eyebogler ',
    //     description: 'Striped Men Polo Neck Blue T-Shirt',
    //     price: 349,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/832/832/kzegk280/t-shirt/j/5/j/xs-t51-eyebogler-original-imagbf497cun2hwx.jpeg?q=70'),
    // Product(
    //     id: 'p2',
    //     title: 'FUBAR',
    //     description: 'Men Slim Fit Solid Mandarin Collar Casual Shirt',
    //     price: 480,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/832/832/kk1h5e80/shirt/x/v/n/xxl-kcsh-110-meh-4-fubar-original-imafzgx2famtvmaz.jpeg?q=70'),
    // Product(
    //     id: 'p3',
    //     title: 'Mosquito Nets',
    //     description:
    //         'HILOF Polyester Adults Washable Nets Foldable Machhardani Adults Maskito Mosquito Net',
    //     price: 599,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/416/416/kz8qsnk0/mosquito-net/h/1/p/double-bed-polyester-adults-blue-mosquito-net-double-bed-nets-original-imagbagfgnfvnquj.jpeg?q=70'),
    // Product(
    //     id: 'p4',
    //     title: 'Moniter',
    //     description: 'SAMSUNG 22 inch Full HD IPS Panel Monitor ',
    //     price: 9999,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/416/416/kynb6vk0/monitor/1/n/s/lf22t354fhwxxl-full-hd-22-lf22t354fhwxxl-samsung-original-imagats2rjbg9uhv.jpeg?q=70'),
    // Product(
    //     id: 'p5',
    //     title: 'Cycle',
    //     description: 'Montra BACKBEAT 27.5 T Mountain Cycle',
    //     price: 24509,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/416/416/l0mr7gw0/cycle/k/e/l/backbeat-27-5-16-5-montra-21-gear-74-original-imagcdmtbhy6qqae.jpeg?q=70'),
    // Product(
    //     id: 'p6',
    //     title: 'Radha Krishna',
    //     description:
    //         'SAF Radha Krishna Large Set of 5 Digital Reprint 18 inch x 42 inch Painting ',
    //     price: 250,
    //     imageUrl:
    //         'https://rukminim1.flixcart.com/image/416/416/kkmwr680/painting/y/x/r/42-sanfpnl31211-saf-original-imafzxvjzwepgfzc.jpeg?q=70'),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchandsetProducts() async {
    const url = 'https://myshop-8c6b8-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if(extractData == null){
        return;
      }
      final List<Product> loadedProducts = [];
      extractData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://myshop-8c6b8-default-rtdb.firebaseio.com/product.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        description: product.description,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://myshop-8c6b8-default-rtdb.firebaseio.com/product/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('....');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://myshop-8c6b8-default-rtdb.firebaseio.com/product/$id.json';

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existProduct);
      notifyListeners();
      throw HttpException('Could not delete product');

    }
    existProduct = null;
  }
}
