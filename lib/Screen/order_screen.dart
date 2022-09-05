import 'package:flutter/material.dart';
import '../Widget/app_drawer.dart';
import '../provider/order.dart' show Orders;
import 'package:provider/provider.dart';
import '../Widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/Orders';

  const OrderScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
