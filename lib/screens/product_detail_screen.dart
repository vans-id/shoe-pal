import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/constants/colors.dart';
import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/providers/product.dart';
import 'package:shoepal/providers/products.dart';
import 'package:shoepal/screens/cart_screen.dart';
import 'package:shoepal/widget/badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final cart = Provider.of<Cart>(context, listen: false);

    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.88,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 350,
                  ),
                ),
                SizedBox(height: 36),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          loadedProduct.title,
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Rp ${numberFormat(loadedProduct.price.toStringAsFixed(0))}',
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Size',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            'Size Guide',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          loadedProduct.description,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: double.infinity,
          height: 90,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 30,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Consumer<Product>(
                    builder: (ctx, product, _) => IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      onPressed: () => product.toggleFavoriteStatus(),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: RaisedButton(
                      color: customBlack,
                      onPressed: () {
                        cart.addItem(
                          loadedProduct.id,
                          loadedProduct.title,
                          loadedProduct.price,
                          loadedProduct.imageUrl,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Add to Cart',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
