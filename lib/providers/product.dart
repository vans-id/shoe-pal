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

  void _setFavStatus(bool newStatus) {
    isFavorite = newStatus;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final url =
        'https://shoepal-7137e.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';

    bool currentStatus = isFavorite;
    _setFavStatus(!currentStatus);

    try {
      final res = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (res.statusCode >= 400) {
        _setFavStatus(currentStatus);
        throw HttpException('Could not delete product');
      }
    } catch (err) {
      _setFavStatus(currentStatus);
    }

    currentStatus = null;
    notifyListeners();
  }
}
