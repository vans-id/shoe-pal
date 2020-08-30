import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/screens/cart_screen.dart';
import 'package:shoepal/widget/badge.dart';
import 'package:shoepal/widget/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavoritesData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('ShoePal'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'Only Favorites',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text(
                  'Show All',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavoritesData = true;
                } else {
                  _showOnlyFavoritesData = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Shoes',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  _showOnlyFavoritesData ? 'Favorites' : 'All',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
          ProductsGrid(_showOnlyFavoritesData),
        ],
      ),
    );
  }
}
