import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/products.dart';
import 'package:shoepal/screens/user_product_item.dart';
import 'package:shoepal/shared/colors.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 16,
        ),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(children: <Widget>[
            UserProductItem(
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: customBlack,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
