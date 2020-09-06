import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/products.dart';
import 'package:shoepal/screens/single_product_screen.dart';
import 'package:shoepal/screens/user_product_item.dart';
import 'package:shoepal/shared/colors.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: customBlack,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(SingleProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: customBlack,
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(children: <Widget>[
              UserProductItem(
                productsData.items[i].id,
                productsData.items[i].title,
                productsData.items[i].imageUrl,
              ),
              Divider(
                color: Colors.grey[700],
              ),
            ]),
            itemCount: productsData.items.length,
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: customBlack,
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(SingleProductScreen.routeName);
      //   },
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
