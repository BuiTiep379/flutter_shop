import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String thumbnail;
  final String thumbnail1;
  final String thumbnail2;
  final String thumbnail3;
  final String price;
  final String color;
  final String size;
  final String description;
  final String promotion;
  final String amount;
  final String brand;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.thumbnail1,
    required this.thumbnail2,
    required this.thumbnail3,
    required this.price,
    required this.color,
    required this.size,
    required this.description,
    required this.promotion,
    required this.amount,
    required this.brand,
    required this.category,
  });

  List<ProductModel> products = [
    ProductModel(
        id: "1",
        name: "name 1",
        thumbnail: "test1",
        thumbnail1: "test1",
        thumbnail2: "test1",
        thumbnail3: "test1",
        price: "1000",
        color: "black",
        size: "41",
        description: "test",
        promotion: "test1",
        amount: "test1",
        brand: "test1",
        category: "test1"),
    ProductModel(
        id: "1",
        name: "name 1",
        thumbnail: "test1",
        thumbnail1: "test1",
        thumbnail2: "test1",
        thumbnail3: "test1",
        price: "1000",
        color: "black",
        size: "41",
        description: "test",
        promotion: "test1",
        amount: "test1",
        brand: "test1",
        category: "test1"),
    ProductModel(
        id: "1",
        name: "name 1",
        thumbnail: "test1",
        thumbnail1: "test1",
        thumbnail2: "test1",
        thumbnail3: "test1",
        price: "1000",
        color: "black",
        size: "41",
        description: "test",
        promotion: "test1",
        amount: "test1",
        brand: "test1",
        category: "test1")
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'thumbnail1': thumbnail1,
      'thumbnail2': thumbnail2,
      'thumbnail3': thumbnail3,
      'price': price,
      'color': color,
      'size': size,
      'promotion': promotion,
      'description': description,
      'amount': amount,
      'brand': brand,
      'category': category,
    };
  }

  ProductModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot["id"],
        name = snapshot["name"],
        thumbnail = snapshot["thumbnail"],
        thumbnail1 = snapshot["thumbnail1"],
        thumbnail2 = snapshot["thumbnail2"],
        thumbnail3 = snapshot["thumbnail3"],
        price = snapshot["price"],
        color = snapshot["color"],
        size = snapshot["size"],
        description = snapshot["description"],
        promotion = snapshot["promotion"],
        amount = snapshot["amount"],
        brand = snapshot["brand"],
        category = snapshot["category"];

  ProductModel.fromMap(Map<String, dynamic> productMap)
      : id = productMap["id"],
        name = productMap["name"],
        thumbnail = productMap["thumbnail"],
        thumbnail1 = productMap["thumbnail1"],
        thumbnail2 = productMap["thumbnail2"],
        thumbnail3 = productMap["thumbnail3"],
        price = productMap["price"],
        color = productMap["color"],
        size = productMap["size"],
        description = productMap["description"],
        promotion = productMap["promotion"],
        amount = productMap["amount"],
        brand = productMap["brand"],
        category = productMap["category"];
}
