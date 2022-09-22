import 'package:flutter/material.dart';
import '../Screen/edit_product_screen.dart';
import '../Widget/app_drawer.dart';
import '../Widget/user_product_item.dart';
import 'package:provider/provider.dart';
import '../provider/product_list.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/UserProduct';

  Future<void> _refreshProducts(BuildContext context) async {
   await Provider.of<Products>(context, listen: false).fetchandsetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh:() => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: productData.items.length,
            itemBuilder: ((ctx, i) => Column(
                  children: [
                    UserProductItem(productData.items[i].id,
                        productData.items[i].title, productData.items[i].imageUrl),
                    Divider(),
                  ],
                )),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
