import "package:flutter/material.dart";

class OrderItem {
  final String title;
  final String id;
  final String thumbnail;
  final int quantity;
  final double price;

  OrderItem({
    required this.title,
    required this.id,
    required this.thumbnail,
    required this.quantity,
    required this.price,
  });
}

class OrderModel with ChangeNotifier {
  Map<String, OrderItem> _items = {};

  Map<String, OrderItem> get items {
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

  void addItems(String title, String id, double price, String thumbnail) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => OrderItem(
            title: existingItem.title,
            price: existingItem.price,
            thumbnail: existingItem.thumbnail,
            id: existingItem.id,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => OrderItem(
          id: DateTime.now().toString(),
          quantity: 1,
          thumbnail: thumbnail,
          title: title,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

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
        (existing) => OrderItem(
          id: existing.id,
          quantity: existing.quantity - 1,
          title: existing.title,
          price: existing.price,
          thumbnail: existing.thumbnail,
        ),
      );
    } else if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
