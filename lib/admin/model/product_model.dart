import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final String thumbnail;
  final String thumbnail1;
  final String thumbnail2;
  final String thumbnail3;
  final String price;
  final String color;
  final String size;
  final String description;
  final String amount;
  final String brand;
  final String category;
  final String type;

  Product({
    required this.name,
    required this.thumbnail,
    required this.thumbnail1,
    required this.thumbnail2,
    required this.thumbnail3,
    required this.price,
    required this.color,
    required this.size,
    required this.description,
    required this.amount,
    required this.brand,
    required this.category,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'thumbnail': thumbnail,
      'thumbnail1': thumbnail1,
      'thumbnail2': thumbnail2,
      'thumbnail3': thumbnail3,
      'price': price,
      'color': color,
      'size': size,
      'description': description,
      'amount': amount,
      'brand': brand,
      'category': category,
      'type': type,
    };
  }

  Product.fromMap(Map<String, dynamic> productMap)
      : name = productMap["name"],
        thumbnail = productMap["thumbnail"],
        thumbnail1 = productMap["thumbnail1"],
        thumbnail2 = productMap["thumbnail2"],
        thumbnail3 = productMap["thumbnail3"],
        price = productMap["price"],
        color = productMap["color"],
        size = productMap["size"],
        description = productMap["description"],
        amount = productMap["amount"],
        brand = productMap["brand"],
        category = productMap["category"],
        type = productMap["type"];
  static Product fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Product(
      name: snapshot.data()!['name'],
      thumbnail: snapshot.data()!['thumbnail'],
      thumbnail1: snapshot.data()!['thumbnail1'],
      thumbnail2: snapshot.data()!['thumbnail2'],
      thumbnail3: snapshot.data()!['thumbnail3'],
      price: snapshot.data()!['price'],
      color: snapshot.data()!['color'],
      size: snapshot.data()!['size'],
      description: snapshot.data()!['description'],
      amount: snapshot.data()!['amount'],
      brand: snapshot.data()!['brand'],
      category: snapshot.data()!['category'],
      type: snapshot.data()!['type'],
    );
  }
}
