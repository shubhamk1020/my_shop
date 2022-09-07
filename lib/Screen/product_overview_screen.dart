import 'package:flutter/material.dart';
import '../Screen/cart_screen.dart';
import 'package:provider/provider.dart';
import '../Widget/app_drawer.dart';
import '../Widget/badge.dart';
import '../Widget/productGrid.dart';
import '../provider/cart.dart';

enum FilterItems {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('myShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterItems selectValue) {
              setState(() {
                if (selectValue == FilterItems.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: FilterItems.Favorites, child: Text('Only Favorites')),
              const PopupMenuItem(
                value: FilterItems.All,
                child: Text('Show all'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavoriteOnly),
    );
  }
}
