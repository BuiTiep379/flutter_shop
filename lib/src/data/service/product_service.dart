import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/Response.dart';

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

  static Stream<QuerySnapshot> readProductfile(query) {
    Query<Object?> notesItemCollection =
        _collection.where("name", arrayContains: query);

    return notesItemCollection.snapshots();
  }

  static Stream<QuerySnapshot> readProductCategory(category) {
    Query<Object?> notesItemCollection =
        _collection.where("category", isEqualTo: category);

    return notesItemCollection.snapshots();
  }

  Future<List<QueryDocumentSnapshot>> getUserUsername(String username) async {
    final Query<Object?> notesItemCollection =
        _collection.where("username", isEqualTo: username);

    final QuerySnapshot querySnapshot = await notesItemCollection.get();
    final List<QueryDocumentSnapshot> documentSnapshots = querySnapshot.docs;

    return documentSnapshots;
  }
}
