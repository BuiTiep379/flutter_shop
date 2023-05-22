import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/admin/admin/categories/components/search_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop_shoes/service/category_service.dart';
import './components/card_category.dart';
import '../base_page.dart';

class CategoryListScreen extends BasePage {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends BasePageState<CategoryListScreen> {
  final Stream<QuerySnapshot> collectionReference =
      CategoryService.readCategories();

  @override
  void initState() {
    super.initState();
    pageTitle = "Categories";
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
                              return CardCategory(
                                  name: e['name'],
                                  imageUrl: e['image'],
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
