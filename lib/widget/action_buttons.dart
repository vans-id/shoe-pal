import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoepal/providers/auth.dart';

import 'package:shoepal/providers/product.dart';
import 'package:shoepal/shared/functions.dart';
import 'package:shoepal/widget/button.dart';

class ActionButtons extends StatelessWidget {
  final Product loadedProduct;

  ActionButtons(this.loadedProduct);

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
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
                    onPressed: () => product.toggleFavoriteStatus(
                      authData.token,
                      authData.userId,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Button(
                  title: 'Add To Cart',
                  onPressed: () => onAddToCart(loadedProduct, context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
