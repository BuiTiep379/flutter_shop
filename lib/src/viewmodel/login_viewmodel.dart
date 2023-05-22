//

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LoginItem {
  final String username;

  LoginItem({
    required this.username,
  });
}

class LoginViewModel with ChangeNotifier {
  Map<String, LoginItem> _items = {};

  Map<String, LoginItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItems(String username) {
    if (_items.containsKey(username)) {
      // increase quantity
      _items.update(
        username,
        (existingItem) => LoginItem(
          username: existingItem.username,
        ),
      );
    } else {
      _items.putIfAbsent(
        username,
        () => LoginItem(
          username: username,
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
  //       (existingItem) => UserItem(
  //             id: existingItem.id,
  //           name: existingItem.name,
  //           username: existingItem.username,
  //           password: existingItem.password,
  //           phone: existingItem.phone,
  //           line: existingItem.line,
  //           district: existingItem.district,
  //           ward: existingItem.ward),
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
}
