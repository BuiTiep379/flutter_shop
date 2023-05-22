import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../const/app_colors.dart';
import '../../../../const/app_font.dart';
import '../../../../viewmodel/whislist_viewmodel.dart';
import 'favorite_item.dart';

class FavoriteScroll extends StatelessWidget {
  final NumberFormat currencyFormat =
      NumberFormat.currency(locale: "vi_VN", symbol: "VND");
  @override
  Widget build(BuildContext context) {
    var wishlistData = Provider.of<WishListViewModel>(context);
    print(wishlistData.itemCount);

    if (wishlistData.itemCount <= 0) {
      return Container(
        child: Center(
          child: Text("Rỗng"),
        ),
      );
    }
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.3),
        itemCount: wishlistData.itemCount,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${wishlistData.items.values.toList()[index].thumbnail}',
                                fit: BoxFit.fill,
                                width: 160,
                                height: 220,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            left: 7,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColorRed,
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: Text(
                                '${wishlistData.items.values.toList()[index].title}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Positioned(
                        //       top: 5,
                        //       right: 7,
                        //       child: Icon(
                        //         Icons.delete_forever,
                        //         color: Colors.white,
                        //       )),
                        // ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            width: 40,
                            height: 40,
                            child: InkWell(
                              onTap: () {
                                wishlistData.removeItem(
                                    wishlistData.items.keys.toList()[index]);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColorRed,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(.2),
                                          offset: Offset(1, 1),
                                          spreadRadius: 3,
                                          blurRadius: 3),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  )),
                            )),
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
                      '${wishlistData.items.values.toList()[index].id}',
                      style: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      '${wishlistData.items.values.toList()[index].category}',
                      style: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 100,
                      child: Text(
                        '${wishlistData.items.values.toList()[index].title}',
                        style: AppFont.bold.copyWith(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${wishlistData.items.values.toList()[index].price}',
                      style: AppFont.bold.copyWith(
                          fontSize: 14, color: AppColors.primaryColorRed),
                    ),
                  ],
                )),
          );
          ;
        },
      ),
    );
  }
}
