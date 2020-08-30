import 'package:flutter/material.dart';

import 'package:shoepal/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Nike Air Max 200 Men\'s shoe',
      description:
          'With exceptional cushioning and modern detailing, the Nike Air Max 200 radiates cool while providing extreme comfort. Its design is inspired by patterns of energy radiating from the earth—like the flow of lava and the ocean\'s rhythmic waves.',
      price: 898000,
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/hqmemh3thbyelz140r7w/air-max-200-shoe-prRmHX.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Nike Air Zoom Pegasus 37',
      description:
          'Reinvigorate your stride with the Nike Air Zoom Pegasus 37. Delivering the same fit and feel that runners love, the shoe has an all-new forefoot cushioning unit and foam for maximum responsiveness. The result is a durable, lightweight trainer designed for everyday running.',
      price: 1799000,
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/33201b0e-8971-45eb-b91b-edac41535f5a/air-zoom-pegasus-37-running-shoe-mwrTCc.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Nike Flex TR 9',
      description:
          'Designed for low-impact workouts and circuit training, the Nike Flex TR 9 pairs a breathable mesh and synthetic upper with a supportive platform designed for flexibility and traction.',
      price: 899000,
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/zqok7zmzp5vxfpxme7do/flex-tr-9-training-shoe-ZR1B84.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Nike Air Zoom Winflo 7',
      description:
          'The Nike Air Zoom Winflo 7 keeps you running with an updated mesh design and increased foam. Designed with longer runs in mind, its cushioned feel helps you stay focused on the path ahead.',
      price: 1429000,
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/i1-89393358-2aa3-4eb5-852b-d05d82e33bf0/air-zoom-wio-7-running-shoe-gHLjtw.jpg',
    ),
  ];

  // var _showFavoritesOnly = false;

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((item) => item.isFavorite).toList();
    // }
    return [..._items];
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }
}
