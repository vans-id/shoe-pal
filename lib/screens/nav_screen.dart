import 'package:flutter/material.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/screens/orders_screen.dart';
import 'package:shoepal/screens/products_overview_screen.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int selectedIndex = 0;
  final widgetOptions = [
    ProductsOverviewScreen(),
    OrdersScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        activeColor: customBlack,
        currentIndex: selectedIndex,
        indicatorColor: customBlack,
        onTap: (index) => onItemTapped(index),
        items: [
          TitledNavigationBarItem(
            title: Text('Home'),
            icon: Icons.home,
          ),
          TitledNavigationBarItem(
            title: Text('Transactions'),
            icon: Icons.compare_arrows,
          ),
        ],
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
