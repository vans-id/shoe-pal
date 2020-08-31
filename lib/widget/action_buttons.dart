import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/providers/product.dart';
import 'package:shoepal/shared/functions.dart';

class ActionButtons extends StatelessWidget {
  final Product loadedProduct;

  ActionButtons(this.loadedProduct);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Container(
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
                    onPressed: () => onAddToCart(loadedProduct, context),
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
    );
  }
}
