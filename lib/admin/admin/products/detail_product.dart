import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../service/product_admin_service.dart';
import '../base_page.dart';
import '../../model/product_model.dart';

class DetailProductScreen extends BasePage {
  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends BasePageState<DetailProductScreen> {
  dynamic argumentData = Get.arguments;
  String id = "";
  bool _showFullDescription = false;
  @override
  void initState() {
    super.initState();
    if (argumentData != null) {
      id = argumentData[0];
    }
    pageTitle = "Detail Product";
  }

  Widget pageUI() {
    final dollarFormatter = CurrencyTextInputFormatter(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );

    return Container(
      color: Colors.white,
      child:StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: ProductService.getProductById(id).asStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Product product = Product.fromSnapshot(snapshot.data!);
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.thumbnail,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      dollarFormatter.format(product.price).toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Color:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.color,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Size:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.size,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Category:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.category,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Brand:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.brand,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount:',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      product.amount,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  product.description.length < 100
                      ? product.description
                      : _showFullDescription
                          ? product.description
                          : product.description.substring(0, 100) + '...',
                  style: TextStyle(fontSize: 18),
                ),
                if (product.description.length > 100)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showFullDescription = !_showFullDescription;
                      });
                    },
                    child: Text(
                      _showFullDescription ? 'Show less' : 'Show more',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    ) 
    ); 
  }
}
