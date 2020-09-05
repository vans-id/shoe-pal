import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shoepal/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Nike Air Max 200 Men\'s shoe',
    //   description:
    //       'With exceptional cushioning and modern detailing, the Nike Air Max 200 radiates cool while providing extreme comfort. Its design is inspired by patterns of energy radiating from the earth—like the flow of lava and the ocean\'s rhythmic waves.',
    //   price: 898000,
    //   imageUrl:
    //       'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/hqmemh3thbyelz140r7w/air-max-200-shoe-prRmHX.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Nike Air Zoom Pegasus 37',
    //   description:
    //       'Reinvigorate your stride with the Nike Air Zoom Pegasus 37. Delivering the same fit and feel that runners love, the shoe has an all-new forefoot cushioning unit and foam for maximum responsiveness. The result is a durable, lightweight trainer designed for everyday running.',
    //   price: 1799000,
    //   imageUrl:
    //       'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/33201b0e-8971-45eb-b91b-edac41535f5a/air-zoom-pegasus-37-running-shoe-mwrTCc.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Nike Flex TR 9',
    //   description:
    //       'Designed for low-impact workouts and circuit training, the Nike Flex TR 9 pairs a breathable mesh and synthetic upper with a supportive platform designed for flexibility and traction.',
    //   price: 899000,
    //   imageUrl:
    //       'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/zqok7zmzp5vxfpxme7do/flex-tr-9-training-shoe-ZR1B84.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Nike Air Zoom Winflo 7',
    //   description:
    //       'The Nike Air Zoom Winflo 7 keeps you running with an updated mesh design and increased foam. Designed with longer runs in mind, its cushioned feel helps you stay focused on the path ahead.',
    //   price: 1429000,
    //   imageUrl:
    //       'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/i1-89393358-2aa3-4eb5-852b-d05d82e33bf0/air-zoom-wio-7-running-shoe-gHLjtw.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://shoepal-7137e.firebaseio.com/products.json';

    try {
      final res = await http.get(url);
      final data = json.decode(res.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];

      data.forEach((prodId, prodData) {
        loadedProduct.insert(
            0,
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
              isFavorite: prodData['isFavorite'],
            ));
      });

      _items = loadedProduct;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    // firebase url
    const url = 'https://shoepal-7137e.firebaseio.com/products.json';

    try {
      final res = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        id: json.decode(res.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      // _items.add(newProduct);
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  void editProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((item) => item.id == id);
    _items[prodIndex] = newProduct;

    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((item) => item.id == id);

    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }
}
