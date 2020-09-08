import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/orders.dart' show Orders;
import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Orders>(context).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(
          context,
          listen: false,
        ).fetchAndSetOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(customBlack),
              ),
            );
          } else if (snapshot.error != null) {
            // Do error handling
            return Center(
              child: Text(
                'Something went wrong. Please try again later',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            );
          } else {
            return RefreshIndicator(
              backgroundColor: customBlack,
              onRefresh: () => _refreshProduct(context),
              child: Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
