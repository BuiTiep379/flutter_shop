import 'package:flutter/material.dart';
import '../base_page.dart';
import '../../service/order_service.dart';
import './components/order_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './components/search_input.dart';

class OrderListScreen extends BasePage {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends BasePageState<OrderListScreen> {
  final Stream<QuerySnapshot> collectionReference = OrderService.readOrders();

  @override
  void initState() {
    super.initState();
    pageTitle = "Orders";
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
            const SearchInput(),
            const SizedBox(
              height: 10,
            ),
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
                            final data = e.data() as Map<String, dynamic>;
                            final orderitems = data.containsKey('orderitems')
                                ? data['orderitems'] as List<dynamic>
                                : [];
                            final thumbnail = orderitems.isNotEmpty
                                ? orderitems[0]['thumbnail'] as String
                                : '';
                            return OrderCard(
                              status: data['status'],
                              total: data['total'],
                              id: e.id,
                              thumbnail: thumbnail,
                              product: data['product'],
                            );
                          }).toList(),
                        ),
                      );
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
