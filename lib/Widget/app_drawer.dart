import 'package:flutter/material.dart';
import 'package:my_shop/Screen/order_screen.dart';
import 'package:my_shop/Screen/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: const Text('hello Friend!'),
          automaticallyImplyLeading: false,
        ),
        const Divider(),

        ListTile(
          leading: const Icon(Icons.shop),
          title: const Text('Shop'),
          onTap: (() {
            Navigator.of(context).pushReplacementNamed('/');
          }),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Orders'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
          },
        ),
         const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Manage Products'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
          },
        ),
      ]),
    );
  }
}
