import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
// import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/providers/products.dart';
// import 'package:shoepal/screens/cart_screen.dart';
import 'package:shoepal/widget/action_buttons.dart';
// import 'package:shoepal/widget/badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      bottomNavigationBar: ActionButtons(loadedProduct),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Detail'),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: loadedProduct.id,
                child: ClipRRect(
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
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
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
                  SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// extendBodyBehindAppBar: true,
// appBar: AppBar(
//   backgroundColor: Colors.transparent,
//   elevation: 0,
//   actions: [
//     Consumer<Cart>(
//       builder: (_, cart, ch) => Badge(
//         child: ch,
//         value: cart.itemCount.toString(),
//       ),
//       child: IconButton(
//         icon: Icon(Icons.shopping_bag_outlined),
//         onPressed: () {
//           Navigator.of(context).pushNamed(CartScreen.routeName);
//         },
//       ),
//     )
//   ],
// ),
// body: SizedBox(
//   height: MediaQuery.of(context).size.height * 0.88,
//   child: CustomScrollView(
//     child: Column(
//       children: [
//         Hero(
//           tag: loadedProduct.id,
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(30),
//               bottomRight: Radius.circular(30),
//             ),
//             child: Image.network(
//               loadedProduct.imageUrl,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 350,
//             ),
//           ),
//         ),
//         SizedBox(height: 36),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   loadedProduct.title,
//                   style: Theme.of(context).textTheme.headline1,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 12),
//               Center(
//                 child: Text(
//                   'Rp ${numberFormat(loadedProduct.price.toStringAsFixed(0))}',
//                   style: Theme.of(context).textTheme.headline2,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 36),
//               Text(
//                 'Details',
//                 style: Theme.of(context).textTheme.headline3,
//               ),
//               SizedBox(height: 12),
//               SizedBox(
//                 width: double.infinity,
//                 child: Text(
//                   loadedProduct.description,
//                   softWrap: true,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// bottomNavigationBar: ActionButtons(loadedProduct),
