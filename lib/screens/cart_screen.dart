import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/providers/cart.dart' show Cart;
import 'package:shoepal/providers/orders.dart';
import 'package:shoepal/widget/button.dart';
import 'package:shoepal/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'My Bag',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, i) {
                  return CartItem(
                    id: cart.items.values.toList()[i].id,
                    productId: cart.items.keys.toList()[i],
                    title: cart.items.values.toList()[i].title,
                    quantity: cart.items.values.toList()[i].quantity,
                    price: cart.items.values.toList()[i].price,
                    imageUrl: cart.items.values.toList()[i].imageUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        color: Colors.white,
        height: 105,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Chip(
                  label: Text(
                    'Rp ${numberFormat(cart.totalAmmount.toStringAsFixed(0))}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Button('Checkout', () {
                    Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(), cart.totalAmmount);
                    cart.clear();
                  }),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
