import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widget/badge.dart';
import '../Widget/productGrid.dart';

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
                    const PopupMenuItem(value: FilterItems.Favorites, child: Text('Only Favorites')),
                    const PopupMenuItem(
                      value: FilterItems.All,
                      child: Text('Show all'),
                    )
                  ],
                  ),
              Consumer(builder: (c, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(icon: Icon(Icons.shopping_cart),
              onPressed: () {
                
              },
              ),
              ),    
        ],
      ),
      body: ProductsGrid(_showFavoriteOnly),
    );
  }
}
