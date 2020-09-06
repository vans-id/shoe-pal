import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoepal/providers/products.dart';

import 'package:shoepal/screens/single_product_screen.dart';
import 'package:shoepal/shared/colors.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SingleProductScreen.routeName,
                  arguments: id,
                );
              },
              color: customBlack,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    title: Text(
                      'Delete Product?',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    content: Text(
                      'Please consider this action cannot be undo',
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
                        onPressed: () async {
                          try {
                            await Provider.of<Products>(context, listen: false)
                                .deleteProduct(id);
                            Navigator.of(ctx).pop(true);
                          } catch (err) {
                            scaffold.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Deleting failed',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            );
                          }
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
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
