import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shoepal/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String prodId) async {
    final url = 'https://shoepal-7137e.firebaseio.com/products/$id.json';

    bool currentStatus = isFavorite;
    isFavorite = !currentStatus;
    notifyListeners();

    final res = await http.patch(
      url,
      body: json.encode(
        {
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
          'isFavorite': isFavorite,
        },
      ),
    );
    if (res.statusCode >= 400) {
      isFavorite = currentStatus;
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    currentStatus = null;
  }
}
