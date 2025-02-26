import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shoepal/helpers/custom_route.dart';

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
import 'package:shoepal/screens/splash_screen.dart';
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
        ChangeNotifierProvider.value(
          value: Cart(),
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
        ),
        ListenableProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, prevOrders) => Orders(
            auth.token,
            auth.userId,
            prevOrders == null ? [] : prevOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'ShoePal',
          theme: ThemeData(
            primaryColor: customPrimary,
            primarySwatch: customPrimary,
            fontFamily: 'Montserrat',
            // pageTransitionsTheme: PageTransitionsTheme(builders: {
            //   TargetPlatform.android: CustomPageTransitionBuilder(),
            //   TargetPlatform.iOS: CustomPageTransitionBuilder(),
            // }),
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
          home: authData.isAuth
              ? NavScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
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
