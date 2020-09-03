import 'package:flutter/material.dart';
import 'package:shoepal/shared/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;

  Button(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: RaisedButton(
        color: customBlack,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
