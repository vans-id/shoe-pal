import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/products.dart';
import 'package:shoepal/screens/single_product_screen.dart';
import 'package:shoepal/widget/user_product_item.dart';
import 'package:shoepal/shared/colors.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);

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
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(customBlack),
                    ),
                  )
                : RefreshIndicator(
                    backgroundColor: customBlack,
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
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
