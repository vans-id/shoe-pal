import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shoepal/screens/user_products_screen.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/screens/orders_screen.dart';
import 'package:shoepal/screens/products_overview_screen.dart';

class NavScreen extends StatefulWidget {
  static const routeName = '/navs';

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final widgetOptions = [
    ProductsOverviewScreen(),
    OrdersScreen(),
    UserProductsScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: CurvedNavigationBar(
          height: 50.0,
          color: customBlack,
          buttonBackgroundColor: customBlack,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          index: _selectedIndex,
          onTap: (index) => onItemTapped(index),
          items: [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.compare_arrows, size: 30, color: Colors.white),
            Icon(Icons.list, size: 30, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
