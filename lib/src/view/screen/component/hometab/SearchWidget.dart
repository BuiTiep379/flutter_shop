import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/service/product_service.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:indexed/indexed.dart';

class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List searchResult = [];

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection("products")
        .where("name", isGreaterThanOrEqualTo: query)
        .where('name', isLessThan: query + '\uf8ff')
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(searchResult.length);
    return SizedBox(
      height: searchResult.length > 0 ? 150 : 80,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Theme(
                child: TextField(
                  onChanged: (query) {
                    searchFromFirebase(query.toString());
                  },
                  // controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    fillColor: Color(0xFFF2F4F5),
                    hintStyle: new TextStyle(color: Colors.grey[600]),
                    hintText: "Search ?",
                  ),
                  autofocus: false,
                ),
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.grey[600],
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.toNamed("/product-detail", arguments: {
                          "id": searchResult[index]["id"],
                          "name": searchResult[index]["name"],
                          "thumbnail": searchResult[index]["thumbnail"],
                          "thumbnail1": searchResult[index]["thumbnail1"],
                          "thumbnail2": searchResult[index]["thumbnail2"],
                          "thumbnail3": searchResult[index]["thumbnail3"],
                          "price": searchResult[index]["price"],
                          "color": searchResult[index]["color"],
                          "size": searchResult[index]["size"],
                          "description": searchResult[index]["description"],
                          "promotion": searchResult[index]["promotion"],
                          "amount": searchResult[index]["amount"],
                          "brand": searchResult[index]["brand"],
                          "category": searchResult[index]["category"]
                        });
                      },
                      title: Text(searchResult[index]["name"]),
                      subtitle: Text(searchResult[index]["price"]),
                    );
                  }))
        ],
      ),
    );
  }
}
