import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  final String name;

  ItemModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  ItemModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot["id"],
        name = snapshot["name"];

  ItemModel.fromMap(Map<String, dynamic> productMap)
      : id = productMap["id"],
        name = productMap["name"];
}
