import 'package:flutter/material.dart';
import 'package:shoepal/shared/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isLoading;

  Button({
    this.title,
    this.onPressed,
    this.isLoading = false,
  });

  Widget setButtonChild(BuildContext ctx) {
    if (isLoading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(customBlack),
      );
    } else {
      return Text(
        title,
        style: Theme.of(ctx).textTheme.headline3.copyWith(color: Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: RaisedButton(
          color: customBlack,
          onPressed: isLoading ? null : onPressed,
          child: setButtonChild(context),
        ),
      ),
    );
  }
}
