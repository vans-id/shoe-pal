import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/products.dart';
import 'package:shoepal/widget/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favoriteItems : productsData.items;

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          // create: (c) => products[i],
          value: products[i],
          child: ProductItem(),
        ),
      ),
    );
  }
}
