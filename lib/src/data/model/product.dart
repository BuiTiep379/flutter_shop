// import 'inventory.dart';

// class Product {
//   String? id;
//   String? title;
//   String? description;
//   double? price;
//   int? amountProduct;
//   String? createAt;
//   bool? isLike;
//   List<String>? urlImage;
//   String? category;
//   List<Inventory>? inventory;

//   Product(
//       {this.id,
//       this.title,
//       this.description,
//       this.price,
//       this.amountProduct,
//       this.createAt,
//       this.isLike,
//       this.urlImage,
//       this.category,
//       this.inventory});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     description = json['description'];
//     price = json['price'];
//     amountProduct = json['amountProduct'];
//     createAt = json['createAt'];
//     isLike = json['isLike'];
//     urlImage = json['urlImage'].cast<String>();
//     category = json['category'];
//     if (json['inventory'] != null) {
//       inventory = [];
//       json['inventory'].forEach((v) {
//         inventory?.add(new Inventory.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['price'] = this.price;
//     data['amountProduct'] = this.amountProduct;
//     data['createAt'] = this.createAt;
//     data['isLike'] = this.isLike;
//     data['urlImage'] = this.urlImage;
//     data['category'] = this.category;
//     if (this.inventory != null) {
//       data['inventory'] = this.inventory?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

//   Product copyWith(
//       {String? id,
//       String? title,
//       String? description,
//       double? price,
//       int? amountProduct,
//       int? isLike,
//       List<String>? urlImage,
//       String? category,
//       List<Inventory>? inventory}) {
//     return Product(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       amountProduct: amountProduct ?? this.amountProduct,
//       urlImage: urlImage ?? this.urlImage,
//       category: createAt ?? this.category,
//       inventory: inventory ?? this.inventory,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
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

  Product({
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

  // List<Product> products = [
  //   Product(
  //       id: "1",
  //       name: "name 1",
  //       thumbnail: "test1",
  //       thumbnail1: "test1",
  //       thumbnail2: "test1",
  //       thumbnail3: "test1",
  //       price: "1000",
  //       color: "black",
  //       size: "41",
  //       description: "test",
  //       promotion: "test1",
  //       amount: "test1",
  //       brand: "test1",
  //       category: "test1"),
  //   Product(
  //       id: "1",
  //       name: "name 1",
  //       thumbnail: "test1",
  //       thumbnail1: "test1",
  //       thumbnail2: "test1",
  //       thumbnail3: "test1",
  //       price: "1000",
  //       color: "black",
  //       size: "41",
  //       description: "test",
  //       promotion: "test1",
  //       amount: "test1",
  //       brand: "test1",
  //       category: "test1"),
  //   Product(
  //       id: "1",
  //       name: "name 1",
  //       thumbnail: "test1",
  //       thumbnail1: "test1",
  //       thumbnail2: "test1",
  //       thumbnail3: "test1",
  //       price: "1000",
  //       color: "black",
  //       size: "41",
  //       description: "test",
  //       promotion: "test1",
  //       amount: "test1",
  //       brand: "test1",
  //       category: "test1")
  // ];

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

  Product.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
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

  Product.fromMap(Map<String, dynamic> productMap)
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

  Product copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? thumbnail1,
    String? thumbnail2,
    String? thumbnail3,
    String? price,
    String? color,
    String? size,
    String? description,
    String? promotion,
    String? amount,
    String? brand,
    bool? isLike,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      thumbnail1: thumbnail1 ?? this.thumbnail1,
      thumbnail2: thumbnail2 ?? this.thumbnail2,
      thumbnail3: thumbnail3 ?? this.thumbnail3,
      price: price ?? this.price,
      color: color ?? this.color,
      size: size ?? this.size,
      description: description ?? this.description,
      promotion: promotion ?? this.promotion,
      amount: amount ?? this.amount,
      brand: brand ?? this.brand,
      category: category ?? this.category,
    );
  }
}
