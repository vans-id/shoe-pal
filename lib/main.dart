import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/providers/auth.dart';
import 'package:shoepal/providers/cart.dart';
import 'package:shoepal/providers/orders.dart';
import 'package:shoepal/providers/products.dart';
import 'package:shoepal/screens/auth_screen.dart';
import 'package:shoepal/screens/single_product_screen.dart';
import 'package:shoepal/screens/user_products_screen.dart';
import 'package:shoepal/screens/cart_screen.dart';
import 'package:shoepal/screens/nav_screen.dart';
import 'package:shoepal/screens/orders_screen.dart';
import 'package:shoepal/screens/product_detail_screen.dart';
// import 'package:shoepal/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ListenableProxyProvider<Auth, Products>(
          create: (ctx) => Products(
            null,
            [],
            null,
          ),
          update: (ctx, auth, prevProducts) => Products(
            auth.token,
            prevProducts == null ? [] : prevProducts.items,
            auth.userId,
          ),
          lazy: false,
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ListenableProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, []),
          update: (ctx, auth, prevOrders) => Orders(
            auth.token,
            prevOrders == null ? [] : prevOrders.orders,
          ),
          lazy: false,
        ),
        // ChangeNotifierProvider.value(
        //   value: Products(),
        // ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'ShoePal',
          theme: ThemeData(
            primaryColor: customPrimary,
            primarySwatch: customPrimary,
            fontFamily: 'Montserrat',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline1: TextStyle(
                    fontSize: 36,
                    color: customBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  headline2: TextStyle(
                    fontSize: 24,
                    color: customBlack,
                    fontWeight: FontWeight.w400,
                  ),
                  headline3: TextStyle(
                    fontSize: 18,
                    color: customBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  bodyText1: TextStyle(
                    color: customBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  bodyText2: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle1: TextStyle(
                    color: customBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  subtitle2: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
          ),
          // home: NavScreen(),
          home: authData.isAuth ? NavScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            SingleProductScreen.routeName: (ctx) => SingleProductScreen(),
          },
        ),
      ),
    );
  }
}
