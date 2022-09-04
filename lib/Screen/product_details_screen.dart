import 'package:flutter/material.dart';
import '../provider/product_list.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/Product-Details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Image.network(loadedProduct.imageUrl,
                fit: BoxFit.contain, alignment: Alignment.center),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text('\u20B9 ${loadedProduct.price}', style: TextStyle(color: Colors.black,fontSize: 20),),
          
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(loadedProduct.description,textAlign: TextAlign.center,softWrap: true,),
            
            
          )
        ],
      )),
    );
  }
}
