import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoepal/constants/colors.dart';

import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/providers/product.dart';
import 'package:shoepal/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

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
                onPressed: () {
                  cart.addItem(
                    product.id,
                    product.title,
                    product.price,
                    product.imageUrl,
                  );
                },
              ),
              Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  color: Colors.black,
                  onPressed: () => product.toggleFavoriteStatus(),
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
