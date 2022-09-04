import 'package:flutter/material.dart';
import 'provider/cart.dart';
import 'provider/product_list.dart';
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
       ChangeNotifierProvider(
        create: (context) => Products(), ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
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
          },
        ),
        );
  }
}
