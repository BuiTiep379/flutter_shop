import 'package:flutter_shop_shoes/src/view/screen/component/favoritetab/favorite_scroll.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: FavoriteScroll(),
      ),
    );
  }
}
