import 'package:flutter/material.dart';

Map<int, Color> primaryShades = {
  50: Color(0xFFfffaf6),
  100: Color(0xFFfef6ed),
  200: Color(0xFFfdecdb),
  300: Color(0xFFfde3c9),
  400: Color(0xFFfcd9b7),
  500: Color(0xFFfbd0a5),
  600: Color(0xFFfbd0a5),
  700: Color(0xFFe2bb95),
  800: Color(0xFFc9a684),
  900: Color(0xFF977d63),
};

MaterialColor customPrimary = MaterialColor(0xFFfbd0a5, primaryShades);
Color customBlack = Color(0xFF1C1F26);
Color customGrey = Color(0xFFADB8D6);

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

String numberFormat(String price) {
  String result = price.replaceAllMapped(reg, mathFunc);
  // print('$test -> $result');
  return result;
}
