import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shop_shoes/service/product_service.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/model/product.dart';
import 'package:flutter_shop_shoes/src/data/service/order_service.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/src/viewmodel/user_viewmodel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../admin/admin/orders/components/order_card.dart';
import '../../const/app_colors.dart';
import '../../viewmodel/whislist_viewmodel.dart';
import 'component/hometab/cart_product.dart';
import 'order_card_client.dart';

class ListOrderScreen extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrderScreen> {
  final Stream<QuerySnapshot> collectionReferenceProduct =
      ProductService.readProduct();

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishListViewModel>(context, listen: false);
    var wishlistData = Provider.of<WishListViewModel>(context);

    ProductViewModel prductVM = Provider.of(context, listen: false);
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);
    var userData = Provider.of<UserViewModel>(context, listen: true);

    final Stream<QuerySnapshot> getOrders =
        OrderService.readOrder(userData!.items.values.toList()[0].username);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "List Order",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Flexible(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: StreamBuilder(
              stream: getOrders,
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
                        return OrderCardClient(
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
      ),
    );
  }

  Widget buildHeaderBody({required String title, required String description}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: AppFont.bold.copyWith(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: AppFont.regular.copyWith(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          'View all',
          style: AppFont.regular.copyWith(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class $ {}
