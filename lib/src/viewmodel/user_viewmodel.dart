//

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class UserItem {
  final String id;
  final String name;
  final String username;
  final String password;
  final String phone;
  final String line;
  final String district;
  final String ward;
  final String uid;

  UserItem({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
    required this.line,
    required this.district,
    required this.ward,
    required this.uid,
  });
}

class UserViewModel with ChangeNotifier {
  Map<String, UserItem> _items = {};

  Map<String, UserItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItems(String id, String name, String username, String password,
      String phone, String line, String district, String ward, String uid) {
    if (_items.containsKey(id)) {
      // increase quantity
      _items.update(
        id,
        (existingItem) => UserItem(
            id: existingItem.id,
            name: existingItem.name,
            username: existingItem.username,
            password: existingItem.password,
            phone: existingItem.phone,
            line: existingItem.line,
            district: existingItem.district,
            ward: existingItem.ward,
            uid: existingItem.uid),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => UserItem(
            id: id,
            name: name,
            username: username,
            password: password,
            phone: phone,
            line: line,
            district: district,
            ward: ward,
            uid: uid),
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
