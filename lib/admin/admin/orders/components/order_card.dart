import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import '../details_order.dart';

class OrderCard extends StatelessWidget {
  final String status;
  final String total;
  final String id;
  final String thumbnail;
  final String product;

  const OrderCard({
    Key? key,
    required this.status,
    required this.total,
    required this.id,
    required this.thumbnail,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dollarFormatter = CurrencyTextInputFormatter(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    return GestureDetector(
        onTap: () {
          print(id);
          Get.to(DetailOrderScreen(), arguments: [id]);
        },
        child: SizedBox(
          height: 120,
          child: Card(
            margin: const EdgeInsets.only(top: 10.0),
            color: Colors.white,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        thumbnail.toString(),
                        height: 300, // set the height to 200 pixels
                        width: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text(
                              'ID: $id',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text(
                              'Quantity: $product',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 5.0),
                              child: Text(
                                dollarFormatter
                                    .format(total)
                                    .toString()
                                    .toLowerCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 30.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                status.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
