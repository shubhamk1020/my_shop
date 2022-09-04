import 'package:flutter/material.dart';
import '../provider/product_list.dart';
import 'package:provider/provider.dart';
import '../Widget/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFabs;

  const ProductsGrid(this.showFabs);


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFabs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl
            ),
      ),
      itemCount: products.length,
    );
  }
}
