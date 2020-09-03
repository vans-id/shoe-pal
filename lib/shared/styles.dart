import 'package:flutter/material.dart';

import 'package:shoepal/shared/colors.dart';

InputDecoration giveInputStyle(String title) {
  return InputDecoration(
    labelText: title,
    labelStyle: TextStyle(
      color: customBlack,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: customBlack, width: 2),
    ),
    errorStyle: TextStyle(fontFamily: 'Montserrat'),
  );
}
