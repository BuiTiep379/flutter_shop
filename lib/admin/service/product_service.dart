import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addProduct(Product productData) async {
    await _db.collection("products").add(productData.toMap());
  }
  /*
  updateProduct(ProductModel productData) async {
    await _db
        .collection("products")
        .doc(productData.id)
        .update(productData.toMap());
  }
  */

  Future<void> deleteProduct(String documentId) async {
    await _db.collection("products").doc(documentId).delete();
  }

  Future<List<Object>> retrieveProduct() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("products").get();
    return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList(); //error
  }

  // final CollectionReference productList =
  //     FirebaseFirestore.instance.collection('products');

  // Future getProductList() async {
  //   List itemList = [];
  //   try {
  //     await productList.get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((element) {
  //         itemList.add(element.data);
  //       });
  //     });
  //     return itemList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
