import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/service/category_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/app_font.dart';

class CategoryTab extends StatelessWidget {
  final Stream<QuerySnapshot> getCategory = CategoryService.readCategories();

  @override
  Widget build(BuildContext context) {
    double cardWidth = ((MediaQuery.of(context).size.width - 40) / 2);

    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: SizedBox(
        child: StreamBuilder(
          stream: getCategory,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10.0),
                children: snapshot.data!.docs.map((e) {
                  print(e);
                  return Card(
  margin: EdgeInsets.all(8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    side: BorderSide(color: Colors.orange),
  ),
  child: GridTile(
    child: InkWell(
      onTap: () {
        Get.toNamed("/category-product", arguments: {
          "name": e["name"],
        });
      },
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        e["image"],
                        fit: BoxFit.fill,
                        width: 220,
                        height: 140,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: SizedBox(
                child: Text(
                  e["name"],
                  textAlign: TextAlign.center,
                  style: AppFont.regular.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ),
              
            ],
          ),
        ),
      ),
    ),
); 
                }).toList(),
              );
            }

            return SizedBox(
              height: 100,
              child: Container(
                child: Text("null"),
              ),
            );
          },
        ),
      ),
    );
  }
}
