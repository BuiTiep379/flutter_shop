import 'package:flutter_shop_shoes/admin/model/product_model.dart';

import 'account_model.dart';
import 'note_model.dart';

class OrderitemModel {
  final String id;
  final Product product;
  final String amount;

  OrderitemModel({
    required this.id,
    required this.product,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'amount': amount,
    };
  }

  OrderitemModel.fromMap(Map<String, dynamic> orderitem)
      : id = orderitem["id"],
        product = orderitem["product"],
        amount = orderitem["amount"];
}
