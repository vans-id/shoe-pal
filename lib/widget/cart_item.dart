import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Dismissible(
        key: ValueKey(id),
        background: Container(
          decoration: BoxDecoration(
            color: customBlack,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 30),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                'Are you sure?',
                style: Theme.of(context).textTheme.headline2,
              ),
              content: Text(
                'Do you want remove this item from your bag?',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          );
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    title,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${numberFormat(price.toStringAsFixed(0))}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        'x$quantity',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ListTile(
//         leading: SizedBox(
//           width: 150,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         title: Text(title),
//         subtitle: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Rp ${price.toStringAsFixed(0)}'),
//             Text('x$quantity'),
//           ],
//         ),
//       ),
