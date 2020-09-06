import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/providers/product.dart';
import 'package:shoepal/screens/product_detail_screen.dart';
import 'package:shoepal/shared/functions.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag_outlined),
                color: Colors.black,
                onPressed: () => onAddToCart(product, context),
              ),
              Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  color: Colors.black,
                  onPressed: () => product.toggleFavoriteStatus(product.id),
                ),
              ),
            ],
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: Column(
            children: [
              SizedBox(
                height: 18,
                child: Text(
                  product.title,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Rp ${numberFormat(product.price.toStringAsFixed(0))}',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// GridTileBar(
//         title: Text(
//           title,
//           style: TextStyle(
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         trailing: Text(
//           price.toStringAsFixed(0),
//           style: TextStyle(
//             color: Colors.black,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       )
