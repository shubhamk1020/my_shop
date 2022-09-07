import 'package:flutter/material.dart';
import 'package:my_shop/Screen/edit_product_screen.dart';
import 'package:my_shop/Screen/order_screen.dart';
import 'package:my_shop/Screen/user_product_screen.dart';
import './Screen/cart_screen.dart';
import './provider/order.dart';
import './provider/cart.dart';
import './provider/product_list.dart';
import 'package:provider/provider.dart';
import './Screen/product_details_screen.dart';
import './Screen/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
       ChangeNotifierProvider(create: (ctx) => Products()
       ),
        ChangeNotifierProvider(create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx) => Orders()
        ),
    ],
      
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(fontFamily: 'Lato', colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue).copyWith(secondary: Colors.deepOrange
            ),
      
          ),
          home: ProductOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName : (ctx) => CartScreen(),
            OrderScreen.routeName : (ctx) => OrderScreen(),
            UserProductScreen.routeName : (ctx) => UserProductScreen(),
            EditProductScreen.routeName : (ctx) => EditProductScreen(),
          },
        ),
        );
  }
}
