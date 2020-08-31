import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/providers/product.dart';

void onAddToCart(Product loadedProduct, BuildContext context) {
  final cart = Provider.of<Cart>(context, listen: false);

  cart.addItem(
    loadedProduct.id,
    loadedProduct.title,
    loadedProduct.price,
    loadedProduct.imageUrl,
  );
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Added item to cart',
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          cart.removeSingleItem(loadedProduct.id);
        },
      ),
    ),
  );
}
