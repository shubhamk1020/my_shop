import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String productId;
  final String id;
  final double price;
  final int quantity;

  const CartItem(
      this.title, this.productId, this.id, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: const Icon(
            Icons.delete,
            size: 40,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content:
                        const Text('Do you want to remove the item from the cart?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text('No'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(true);
                          },
                          child: const Text('Yes'))
                    ],
                  ),
                  );
        },
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          elevation: 5,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FittedBox(child: Text('\u20B9 $price')),
                  ),
                ),
                title: Text(title),
                subtitle: Text('Total:\u20B9 ${(price * quantity)}'),
                trailing: Text('$quantity x'),
              )),
        ),
      ),
    );
  }
}
