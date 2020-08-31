import 'package:flutter/material.dart';
import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('ShoePal'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: customBlack,
            ),
            title: Text('Home'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.transform_rounded,
              color: customBlack,
            ),
            title: Text('Transactions'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          Divider(),
        ],
      ),
    );
  }
}
