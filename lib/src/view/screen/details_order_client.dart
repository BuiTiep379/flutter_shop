import 'package:flutter/material.dart';
import '../../../admin/admin/base_page.dart';
import '../../../admin/admin/orders/components/order_item_card.dart';
import '../../../admin/model/order_model.dart';
import '../../../admin/service/order_service.dart';
import '../../../admin/utils/text_custom.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class DetailOrderClientScreen extends BasePage {
  @override
  _DetailOrderClientScreenState createState() =>
      _DetailOrderClientScreenState();
}

class _DetailOrderClientScreenState
    extends BasePageState<DetailOrderClientScreen> {
  dynamic argumentData = Get.arguments;
  String id = "";
  String status = "";

  @override
  void initState() {
    super.initState();
    if (argumentData != null) {
      id = argumentData[0];
    }
    pageTitle = "Order detail";
  }

  Future saveOrder(String status) async {
    String statusChange = status == "Pending" ? "Delivery" : "Completed";
    var response = await OrderService.updateOrderStatus(
        docId: id, newStatus: statusChange);
    if (response.code != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message.toString()),
          backgroundColor: Colors.green,
        ),
      );
    }
    Get.back();
  }

  Widget pageUI() {
    final dollarFormatter = CurrencyTextInputFormatter(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    final changeStatusButton = ElevatedButton(
      onPressed: () => {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              text: "Change status",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return Container(
        color: Colors.white,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: OrderService.getOrderById(id).asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Order _order = Order.fromSnapshot(snapshot.data!);
            String totalAmount =
                dollarFormatter.format(_order.total).toString();
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomText(
                          text: "ID: $id",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 10.0),
                      CustomText(
                          text: "Amount: $totalAmount",
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: CustomText(
                            text: _order.status.toString(),
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      CustomText(
                          text: "Delivery Address",
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        height: 140,
                        child: Card(
                          margin: const EdgeInsets.only(top: 10.0),
                          color: Colors.white,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.cyan,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: CustomText(
                                      text: "Home",
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: CustomText(
                                    text: _order.username,
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: CustomText(
                                    text:
                                        '${_order.line} ${_order.district} ${_order.ward}',
                                    fontSize: 16,
                                    color: Color(0xFF5b5b5b),
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: CustomText(
                                    text: _order.phone,
                                    fontSize: 16,
                                    color: Color(0xFF5b5b5b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _order.orderitems.length,
                        itemBuilder: (context, index) {
                          final item = _order.orderitems[index];
                          return OrderItemCard(
                              title: item.title,
                              color: item.color,
                              quantity: item.quantity.toString(),
                              size: item.size,
                              price: item.price.toString(),
                              thumbnail: item.thumbnail);
                        },
                      ),
                      const SizedBox(height: 10),
                    ]),
              ),
            );
          },
        ));
  }
}
