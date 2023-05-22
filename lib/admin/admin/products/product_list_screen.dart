import 'package:flutter/material.dart';
import './components/search_util.dart';
import '../base_page.dart';
import '../../service/product_admin_service.dart';
import './components/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends BasePage {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends BasePageState<ProductListScreen> {
  final Stream<QuerySnapshot> collectionReference =
      ProductService.readProducts();

  @override
  void initState() {
    super.initState();
    pageTitle = "Products";
  }

  @override
  Widget pageUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SearchInput(),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: StreamBuilder(
                  stream: collectionReference,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((e) {
                              return CardProduct(
                                  name: e['name'],
                                  thumbnail: e['thumbnail'],
                                  price: e['price'],
                                  id: e.id);
                            }).toList(),
                          ));
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
