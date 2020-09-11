import 'package:flutter/material.dart';
import 'package:shoepal/shared/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ShoePal',
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: customPrimary,
                  ),
            ),
            SizedBox(height: 12),
            Text(
              'You deserve better shoes',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
