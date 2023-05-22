import "package:flutter/material.dart";

class WishListItem {
  final String title;
  final String id;
  final String thumbnail;
  final int quantity;
  final double price;
  final String category;

  WishListItem({
    required this.title,
    required this.id,
    required this.thumbnail,
    required this.quantity,
    required this.price,
    required this.category,
  });
}

class WishListViewModel with ChangeNotifier {
  Map<String, WishListItem> _items = {};

  Map<String, WishListItem> get items {
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
      String category) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => WishListItem(
            title: existingItem.title,
            price: existingItem.price,
            thumbnail: existingItem.thumbnail,
            category: existingItem.category,
            id: existingItem.id,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => WishListItem(
          id: DateTime.now().toString(),
          quantity: 1,
          thumbnail: thumbnail,
          title: title,
          price: price,
          category: category,
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
        (existing) => WishListItem(
          id: existing.id,
          quantity: existing.quantity - 1,
          title: existing.title,
          price: existing.price,
          thumbnail: existing.thumbnail,
          category: existing.category,
        ),
      );
    } else if (_items[productId]!.quantity == 1) {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
