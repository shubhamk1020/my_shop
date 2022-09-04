import 'package:flutter/cupertino.dart';
import '../Widget/cart_product.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartProduct> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders;

  List<OrderItem> get order {
    return [..._orders];
  }

  void addOrder(List<CartProduct> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProduct,
          dateTime: DateTime.now()),
    );
    ChangeNotifier();
  }
}
