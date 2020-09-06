import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double ammount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.ammount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shoepal-7137e.firebaseio.com/orders.json';

    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final List<OrderItem> loadedProduct = [];

      if (data == null) {
        return;
      }

      data.forEach((orderId, orderData) {
        loadedProduct.insert(
          0,
          OrderItem(
            id: orderId,
            ammount: orderData['ammount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                      imageUrl: item['imageUrl'],
                    ))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });

      _orders = loadedProduct;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://shoepal-7137e.firebaseio.com/orders.json';
    final timestamp = DateTime.now();

    try {
      final res = await http.post(
        url,
        body: json.encode(
          {
            'ammount': total,
            'products': cartProducts
                .map(
                  (cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  },
                )
                .toList(),
            'dateTime': timestamp.toIso8601String(),
          },
        ),
      );

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(res.body)['name'],
          ammount: total,
          products: cartProducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
