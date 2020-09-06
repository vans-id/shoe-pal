import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shoepal/models/http_exception.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  Future<void> removeItem(String productId) async {
    // final url = 'https://shoepal-7137e.firebaseio.com/cart/$productId.json';
    // await http.delete(url);

    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }

  Future<void> addItem(
    String productId,
    String title,
    double price,
    String imageUrl,
  ) async {
    // const url = 'https://shoepal-7137e.firebaseio.com/cart.json';

    // try {
    // if (_items.containsKey(productId)) {
    //   await http.patch(
    //     url,
    //     body: json.encode(
    //       {
    //         'id': _items[productId].id,
    //         'title': _items[productId].title,
    //         'quantity': _items[productId].quantity + 1,
    //         'price': _items[productId].price,
    //         'imageUrl': _items[productId].imageUrl,
    //       },
    //     ),
    //   );

    //   _items.update(
    //     productId,
    //     (existingCartItem) => CartItem(
    //       id: existingCartItem.id,
    //       title: existingCartItem.title,
    //       quantity: existingCartItem.quantity + 1,
    //       price: existingCartItem.price,
    //       imageUrl: existingCartItem.imageUrl,
    //     ),
    //   );
    // } else {
    //   final res = await http.post(
    //     url,
    //     body: json.encode(
    //       {
    //         'title': _items[productId].title,
    //         'quantity': _items[productId].quantity + 1,
    //         'price': _items[productId].price,
    //         'imageUrl': _items[productId].imageUrl,
    //       },
    //     ),
    //   );
    //   _items.putIfAbsent(
    //     productId,
    //     () => CartItem(
    //       id: json.decode(res.body)['name'],
    //       title: title,
    //       quantity: 1,
    //       price: price,
    //       imageUrl: imageUrl,
    //     ),
    //   );
    // }

    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
