import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/orders.dart' show Orders;
import 'package:shoepal/widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
      ),
    );
  }
}
