import 'package:flutter_shop_shoes/src/view/screen/component/hometab/SearchWidget.dart';
import 'package:flutter_shop_shoes/src/view/screen/component/hometab/body_page.dart';
import 'package:flutter_shop_shoes/src/view/screen/component/hometab/header_page.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            SearchWidget(),
            HeaderPage(),
            SizedBox(
              height: 20,
            ),
            BodyPage(),
          ],
        )

            //     Indexer(
            //   children: [
            //     Indexed(
            //       index: 1000,
            //       child: SearchWidget(),
            //     ),
            //     Indexed(index: 1000, child: HeaderPage()),
            //     SizedBox(
            //       height: 20,
            //     ),
            //     Indexed(
            //       index: 3,
            //       child: BodyPage(),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }
}
