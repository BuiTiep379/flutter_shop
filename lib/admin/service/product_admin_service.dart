import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/response_model.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference _collection = db.collection('products');

class ProductService {
  static Future<Response> addProduct({
    required String name,
    required String thumbnail,
    required String thumbnail1,
    required String thumbnail2,
    required String thumbnail3,
    required String price,
    required String color,
    required String size,
    required String description,
    required String amount,
    required String brand,
    required String category,
    required String type,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "thumbnail": thumbnail,
      "thumbnail1": thumbnail1,
      "thumbnail2": thumbnail2,
      "thumbnail3": thumbnail3,
      "price": price,
      "color": color,
      "size": size,
      "description": description,
      "amount": amount,
      "brand": brand,
      "category": category,
      "type": type
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
   static Future<Response> updateProduct({
    required String name,
    required String thumbnail,
    required String thumbnail1,
    required String thumbnail2,
    required String thumbnail3,
    required String price,
    required String color,
    required String size,
    required String description,
    required String amount,
    required String brand,
    required String category,
    required String type,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "thumbnail": thumbnail,
      "thumbnail1": thumbnail1,
      "thumbnail2": thumbnail2,
      "thumbnail3": thumbnail3,
      "price": price,
      "color": color,
      "size": size,
      "description": description,
      "amount": amount,
      "brand": brand,
      "category": category,
      "type": type,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated product";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
    static Future<Response> deleteProduct({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully deleted product";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  static Stream<QuerySnapshot> readProducts() {
    CollectionReference notesItemCollection =
        _collection;

    return notesItemCollection.snapshots();
  }
   static Future<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) async {
    return FirebaseFirestore.instance.collection('products').doc(id).get();
  }
}
