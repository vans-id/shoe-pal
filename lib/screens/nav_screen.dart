import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shoepal/screens/user_products_screen.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/screens/orders_screen.dart';
import 'package:shoepal/screens/products_overview_screen.dart';

class NavScreen extends StatefulWidget {
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
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 74,
        child: CurvedNavigationBar(
          height: 55.0,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: customBlack,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          index: _selectedIndex,
          onTap: (index) => onItemTapped(index),
          items: [
            Icon(
              Icons.home,
              size: 30,
              color: customBlack,
            ),
            Icon(
              Icons.compare_arrows,
              size: 30,
              color: customBlack,
            ),
            Icon(
              Icons.list,
              size: 30,
              color: customBlack,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.local_drink), title: Text('Beers')),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.add_a_photo), title: Text('New Beer')),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), title: Text('Favourites')),
      //   ],
      //   currentIndex: selectedIndex,
      //   fixedColor: Colors.deepPurple,
      //   onTap: onItemTapped,
      // ),
    );
  }
}
