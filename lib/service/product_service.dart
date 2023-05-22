import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response_model.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference _collection = db.collection('products');

class ProductService {
  static Future<Response> addCategory({
    required String name,
    required String image,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "image": image,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateCategory({
    required String name,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated category";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateProduct({
    required String name,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteCategory({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readProduct() {
    CollectionReference notesItemCollection = _collection;

    return notesItemCollection.snapshots();
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../model/product_model.dart';

// class ProductService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   addProduct(ProductModel productData) async {
//     await _db.collection("products").add(productData.toMap());
//   }

//   updateProduct(ProductModel productData) async {
//     await _db
//         .collection("products")
//         .doc(productData.id)
//         .update(productData.toMap());
//   }

//   Future<void> deleteProduct(String documentId) async {
//     await _db.collection("products").doc(documentId).delete();
//   }

//   Future<List<Object>> retrieveProduct() async {
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await _db.collection("products").get();
//     return snapshot.docs
//         .map((e) => ProductModel.fromSnapshot(e))
//         .toList(); //error
//   }

//   // final CollectionReference productList =
//   //     FirebaseFirestore.instance.collection('products');

//   // Future getProductList() async {
//   //   List itemList = [];
//   //   try {
//   //     await productList.get().then((querySnapshot) {
//   //       querySnapshot.docs.forEach((element) {
//   //         itemList.add(element.data);
//   //       });
//   //     });
//   //     return itemList;
//   //   } catch (e) {
//   //     print(e.toString());
//   //     return null;
//   //   }
//   // }
// }
