import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/products/red_shirt.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/products/trousers.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - perfect for winter.',
      price: 19.99,
      imageUrl: 'assets/images/products/yellow_scarf.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you can imagine.',
      price: 49.99,
      imageUrl: 'assets/images/products/pan.jpg',
    ),
  ];

  List<Product> get products => [..._products];

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  void toggleFavoriteStatus(String productId) {
    final productIndex = _products.indexWhere((prod) => prod.id == productId);
    if (productIndex >= 0) {
      _products[productIndex].toggleFavoriteStatus();
      notifyListeners();
    }
  }
}
