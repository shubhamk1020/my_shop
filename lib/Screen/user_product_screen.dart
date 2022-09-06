import 'package:flutter/material.dart';
import 'package:my_shop/Widget/app_drawer.dart';
import 'package:my_shop/Widget/user_product_item.dart';
import 'package:provider/provider.dart';

import '../provider/product_list.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/UserProduct';


  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.add),)
      ],),
      body: ListView.builder(padding: EdgeInsets.all(10),
      itemCount: productData.items.length,
      itemBuilder: ((ctx, i) => Column(children: [
        UserProductItem(productData.items[i].title, productData.items[i].imageUrl)
      ],)),
      ),
      drawer: AppDrawer(),
      
    );
  }
}
