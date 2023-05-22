//

import "package:flutter/material.dart";

class CartItem {
  final String title;
  final String id;
  final String thumbnail;
  final int quantity;
  final double price;
  final String color;
  final String size;

  CartItem({
    required this.title,
    required this.id,
    required this.thumbnail,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'price': price,
      'color': color,
      'size': size
    };
  }
}

class CartViewModel with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total.floorToDouble();
  }

  void addItems(String title, String id, double price, String thumbnail,
      String color, String size) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => CartItem(
            title: existingItem.title,
            price: existingItem.price,
            thumbnail: existingItem.thumbnail,
            id: existingItem.id,
            color: existingItem.color,
            size: existingItem.size,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: DateTime.now().toString(),
          quantity: 1,
          thumbnail: thumbnail,
          title: title,
          price: price,
          color: color,
          size: size,
        ),
      );
    }
    notifyListeners();
  }

  // void addItemsSingle(String title, String id, double price, String thumbnail,
  //     String color, String size) {
  //   print(id);
  //   if (_items.containsKey(id)) {
  //     // increase quantity
  //     _items.update(
  //       id,
  //       (existingItem) => CartItem(
  //           title: existingItem.title,
  //           price: existingItem.price,
  //           thumbnail: existingItem.thumbnail,
  //           id: existingItem.id,
  //           color: existingItem.color,
  //           size: existingItem.size,
  //           quantity: existingItem.quantity + 1),
  //     );
  //   }
  //   notifyListeners();
  // }

  void removeItem(String? productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String? productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId.toString(),
        (existing) => CartItem(
          id: existing.id,
          quantity: existing.quantity - 1,
          title: existing.title,
          price: existing.price,
          thumbnail: existing.thumbnail,
          color: existing.color,
          size: existing.size,
        ),
      );
    } else if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addSingleItem(String? productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity >= 1) {
      _items.update(
        productId.toString(),
        (existing) => CartItem(
          id: existing.id,
          quantity: existing.quantity + 1,
          title: existing.title,
          price: existing.price,
          thumbnail: existing.thumbnail,
          color: existing.color,
          size: existing.size,
        ),
      );
    }
    notifyListeners();
  }
}
