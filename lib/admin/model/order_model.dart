import '../model/cartitem_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Order {
  final String username;
  final String phone;
  final String status;
  final String product;
  final String total;
  final String ward;
  final String district;
  final String line;
  final List<CartItem> orderitems;

  Order({
    required this.username,
    required this.phone,
    required this.status,
    required this.product,
    required this.total,
    required this.ward,
    required this.district,
    required this.line,
    required this.orderitems,
  });
  factory Order.fromMap(Map<String, dynamic> data) {
    final orderItems = (data['orderitems'] as List<dynamic>)
        .map((item) => CartItem(
              id: item['id'],
              title: item['title'],
              thumbnail: item['thumbnail'],
              quantity: item['quantity'],
              price: item['price'],
              color: item['color'],
              size: item['size'],
            ))
        .toList();
    return Order(
      username: data['username'],
      phone: data['phone'],
      status: data['status'],
      product: data['product'],
      total: data['total'],
      ward: data['ward'],
      district: data['district'],
      line: data['line'],
      orderitems: orderItems,
    );
  }
  factory Order.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  final orderitems = (snapshot.data()!['orderitems'] as List<dynamic>)
      .map((item) => CartItem(
            id: item['id'],
            title: item['title'],
            thumbnail: item['thumbnail'],
            quantity: item['quantity'],
            price: item['price'].toDouble(),
            color: item['color'],
            size: item['size'],
          ))
      .toList();
  return Order(
    username: snapshot.data()!['username'],
    phone: snapshot.data()!['phone'],
    status: snapshot.data()!['status'],
    product: snapshot.data()!['product'],
    total: snapshot.data()!['total'],
    ward: snapshot.data()!['ward'],
    district: snapshot.data()!['district'],
    line: snapshot.data()!['line'],
    orderitems: orderitems,
  );
}

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'phone': phone,
      'status': status,
      'product': product,
      'total': total,
      'ward': ward,
      'district': district,
      'line': line,
      'orderitems': orderitems.map((item) => item.toMap()).toList(),
    };
  }
}
