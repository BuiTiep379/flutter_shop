import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class OrderItemCard extends StatelessWidget {
  final String title;
  final String size;
  final String color;
  final String quantity;
  final String thumbnail;
  final String price;

  const OrderItemCard({
    Key? key,
    required this.title,
    required this.size,
    required this.color,
    required this.thumbnail,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  Color getColorFromString(String colorString) {
    switch (colorString) {
      case "black":
        return Colors.black;
      case "white":
        return Colors.white;
      case "red":
        return Colors.red;
      case "green":
        return Colors.green;
      case "blue":
        return Colors.blue;
      case "yellow":
        return Colors.yellow;
      case "orange":
        return Colors.orange;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      case "grey":
        return Colors.grey;
      default:
        throw Exception("Invalid color string: $colorString");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dollarFormatter = CurrencyTextInputFormatter(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    return GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: 150,
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
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12.0, left: 12.0, top: 12.0, right: 5),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Image.network(
                            thumbnail.toString(),
                            height: 300, // set the height to 200 pixels
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        )),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, top: 10.0, right: 10),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 16,
                                  ),
                                  color: getColorFromString(color),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(
                                '$color Color | Size $size | Qty = $quantity',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ]),
                          const SizedBox(height: 6.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 5.0),
                            child: Text(
                              dollarFormatter
                                  .format(price)
                                  .toString()
                                  .toLowerCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.cyan,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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
