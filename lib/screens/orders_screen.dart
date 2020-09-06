import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/providers/orders.dart' show Orders;
import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/widget/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Orders>(context).fetchAndSetOrders();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(customBlack),
              ),
            )
          : RefreshIndicator(
              backgroundColor: customBlack,
              onRefresh: () => _refreshProduct(context),
              child: ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
              ),
            ),
    );
  }
}
