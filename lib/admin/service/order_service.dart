import '../model/order_model.dart';
import '../model/response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference _collection = db.collection('orders');

class OrderService {
  
  static Stream<QuerySnapshot> readOrders() {
    CollectionReference notesItemCollection =
        _collection;

    return notesItemCollection.snapshots();
  }
  static Future<Response> updateOrderStatus({
    required String docId,
    required String newStatus,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "status": newStatus,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully updated order status";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  static Future<DocumentSnapshot<Map<String, dynamic>>> getOrderById(String id) async {
    return FirebaseFirestore.instance.collection('orders').doc(id).get();
  }
}
