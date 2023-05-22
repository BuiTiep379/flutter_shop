import 'dart:math';
import 'dart:ui';

import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_shop_shoes/src/const/app_colors.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/model/inventory.dart';
import 'package:flutter_shop_shoes/src/data/model/product.dart';
import '../screen/cart_tab.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/viewmodel/auth_viemodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/choice_chip.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shop_shoes/src/viewmodel/user_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatefulWidget {
  final Product? product;

  const DetailProductScreen({Key? key, this.product}) : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  List<String> listImage = [
    'https://www.girlteencare.com/wp-content/uploads/2021/04/dd51d83736d0741a3a78ad68e8077805.jpg',
    'https://www.efasheen.com/wp-content/uploads/2020/12/Pantone-Colors.png',
    'https://thevou.com/wp-content/uploads/2021/05/Current-fashion-trends-wtvox.com-Boiler-suits-01.jpg',
  ];
  Inventory? inventory = Inventory();

  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: "vi_VN", symbol: "VND");

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: true);
    final userData = Provider.of<UserViewModel>(context, listen: true);

    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "${Get.arguments["category"]}",
          style: AppFont.semiBold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
              size: 22,
            ),
          ),
          IconButton(
              onPressed: () {
                Get.to(() => CartTab());
              },
              icon: badges.Badge(
                // badgeColor: AppColors.primaryColorRed,
                badgeContent: Text(
                  cartViewModel.itemCount.toString(),
                  style: AppFont.regular
                      .copyWith(fontSize: 12, color: Colors.white),
                ),
                position: badges.BadgePosition.topEnd(top: -8, end: -5),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    height: 330,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    // autoPlay: false,
                  ),
                  items: [
                    Image.network(
                      "${Get.arguments['thumbnail']}",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "${Get.arguments['thumbnail1']}",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "${Get.arguments['thumbnail2']}",
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      "${Get.arguments['thumbnail3']}",
                      fit: BoxFit.cover,
                    )
                  ]),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${Get.arguments['name']}",
                            style: AppFont.bold.copyWith(fontSize: 23),
                          ),
                        ),
                        Text(
                          currencyFormat
                              .format(int.parse(Get.arguments['price'])),
                          style: AppFont.bold.copyWith(fontSize: 23),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${Get.arguments['category']}",
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 5,
                          direction: Axis.horizontal,
                          itemSize: 15,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('(10)')
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${Get.arguments['description']}",
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.4,
                          letterSpacing: .2,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Rating & Review",
                      style: AppFont.bold.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Color",
                      style: AppFont.semiBold.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: EdgeInsets.only(right: 16),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Get.arguments['color'] == "white"
                                            ? Colors.white
                                            : Get.arguments['color'] == "black"
                                                ? Colors.black
                                                : Get.arguments['color'] ==
                                                        "pink"
                                                    ? Colors.pink
                                                    : Colors.green,
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Colors.red, width: 1),
                                        // border: Border.all(
                                        //     color: Colors.deepOrangeAccent, width: 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(207, 207, 207, 1)
                                                    .withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ]),
                                    // child: Center(
                                    //   child: Icon(
                                    //     Icons.auto_graph,
                                    //     color: Colors.black,
                                    //     size: 24.0,
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Size",
                      textAlign: TextAlign.left,
                      style: AppFont.semiBold.copyWith(fontSize: 24),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              GestureDetector(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.only(right: 16),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.red, width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(207, 207, 207, 1)
                                                  .withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ]),
                                  child: Center(
                                      child: Text("${Get.arguments["size"]}")),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext ctx) {
          return Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(2, -2),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                onPressed: () {
                  if (userData.itemCount > 0) {
                    Provider.of<CartViewModel>(ctx, listen: false).addItems(
                        Get.arguments['name'],
                        Get.arguments['id'],
                        int.parse(Get.arguments['price']).toDouble(),
                        Get.arguments['thumbnail'],
                        Get.arguments['color'],
                        Get.arguments['size']);
                    // if (Provider.of<CartViewModel>(ctx, listen: false).message !=
                    //     null) {
                    //   Fluttertoast.showToast(
                    //       msg: Provider.of<CartViewModel>(ctx, listen: false)
                    //           .message);
                    // }
                  } else {
                    Get.toNamed("/login");
                  }
                },
                child: Text(
                  "Add to cart".toUpperCase(),
                  style: AppFont.medium
                      .copyWith(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget buildText(List<String> list) {
  //   return Wrap(
  //     children: list.map((e) => Text(e)).toList(),
  //   );
  // }
}
