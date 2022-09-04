import 'package:flutter/material.dart';
import '../Widget/cart_product.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(children: [
        Card(
          elevation: 4,
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                Spacer(),
                  
                Chip(
                  
                  label: Text('\u20B9 ${cart.totalAmount}'),
                  backgroundColor: Colors.amber,
                ),
                SizedBox(width: 12,),
               // FlatButton(child: Text('Order Now '), onPressed: () {})
                ElevatedButton(onPressed: () {}, child: Text('Order Now'),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10,),
        
        Expanded(
          child: ListView.builder(itemBuilder: (ctx , i) => CartProduct(
            cart.items.values.toList()[i].title,
            cart.items.keys.toList()[i],
           cart.items.values.toList()[i].id, 
           cart.items.values.toList()[i].price, 
           cart.items.values.toList()[i].quantity),
          itemCount: cart.items.length,
          ),
        ),
      ]),
    );
  }
}
