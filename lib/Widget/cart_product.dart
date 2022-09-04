import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartProduct extends StatelessWidget {
  final String title;
  final String productId;
  final String id;
  final double price;
  final int quantity;

  const CartProduct(
      this.title, this.productId, this.id, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          size: 40,
        ),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FittedBox(child: Text('\u20B9 ${price}')),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total:\u20B9 ${(price * quantity)}'),
              trailing: Text('$quantity x'),
            )),
      ),
    );
  }
}
