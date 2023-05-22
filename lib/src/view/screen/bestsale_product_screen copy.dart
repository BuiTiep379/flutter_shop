import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shop_shoes/service/product_service.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/model/product.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/src/viewmodel/user_viewmodel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../const/app_colors.dart';
import '../../viewmodel/whislist_viewmodel.dart';
import 'component/hometab/cart_product.dart';

class BestSalerProductScreen extends StatefulWidget {
  @override
  _BestSalerProductState createState() => _BestSalerProductState();
}

class _BestSalerProductState extends State<BestSalerProductScreen> {
  final Stream<QuerySnapshot> collectionReferenceProduct =
      ProductService.readProduct();

  final Stream<QuerySnapshot> getProductBestSaller =
      UserService.readProductBestSaller("bestsaller");
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: "vi_VN", symbol: "VND");

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishListViewModel>(context, listen: false);
    var wishlistData = Provider.of<WishListViewModel>(context);

    ProductViewModel prductVM = Provider.of(context, listen: false);
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);
    var userData = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => {Get.toNamed("/")},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Best Saler",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Column(
            children: [
              // buildHeaderBody(title: "Sale", description: "Supper sale"),

              SizedBox(
                height: 750,
                child: StreamBuilder(
                  stream: getProductBestSaller,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      // return Container(
                      //   child: Text("tset"),
                      // );

                      return GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        // padding: EdgeInsets.all(1.0),
                        childAspectRatio: 1 / 2,
                        children: snapshot.data!.docs.map((e) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: GridTile(
                              child: InkWell(
                                  onTap: () {
                                    // prductVM.addRecentView(e);
                                    // Navigator.pushNamed(context, DetailProductScreens,
                                    //     arguments: e);

                                    Get.toNamed("/product-detail", arguments: {
                                      "id": e.id,
                                      "name": e["name"],
                                      "thumbnail": e["thumbnail"],
                                      "thumbnail1": e["thumbnail1"],
                                      "thumbnail2": e["thumbnail2"],
                                      "thumbnail3": e["thumbnail3"],
                                      "price": e["price"],
                                      "color": e["color"],
                                      "size": e["size"],
                                      "description": e["description"],
                                      "amount": e["amount"],
                                      "brand": e["brand"],
                                      "category": e["category"]
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, right: 2),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                e["thumbnail"],
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                height: 220,
                                              ),
                                            ),
                                          ),
                                          Consumer<ProductViewModel>(
                                            builder: (BuildContext context,
                                                ProductViewModel value,
                                                Widget? child) {
                                              return Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: InkWell(
                                                  onTap: () {
                                                    wishlist.addItems(
                                                        e['name'],
                                                        e.id,
                                                        int.parse(e['price'])
                                                            as double,
                                                        e['thumbnail'],
                                                        e['category']);
                                                  },
                                                  child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .2),
                                                            offset:
                                                                Offset(1, 1),
                                                            spreadRadius: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Icon(
                                                        Icons.favorite,
                                                        // : Icons
                                                        //     .favorite_border,
                                                        color:
                                                            // ? AppColors
                                                            //     .primaryColorRed
                                                            AppColors
                                                                .primaryColorGray,
                                                        size: 19,
                                                      )),
                                                ),
                                              );
                                            },
                                          )
                                        ],
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
                                        height: 5,
                                      ),
                                      Text(
                                        e["category"],
                                        style: AppFont.regular.copyWith(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        e["name"],
                                        style: AppFont.bold.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        currencyFormat
                                            .format(int.parse(e["price"])),
                                        style: AppFont.bold.copyWith(
                                            fontSize: 14,
                                            color: AppColors.primaryColorRed),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        }).toList(),
                      );
                    }

                    return Center(
                      child: Text("Rỗng"),
                    );
                  },
                ),
              ),
            ],
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
