import 'package:flutter_shop_shoes/src/data/service/order_service.dart';
import 'package:flutter_shop_shoes/src/view/screen/cartutil.dart';
import 'package:flutter_shop_shoes/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../const/app_colors.dart';
import '../../const/app_font.dart';
import '../../router/router_path.dart';
import '../../viewmodel/user_viewmodel.dart';

class NotifycationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartViewModel>(context);
    var userData = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
          "Notifications",
          style: AppFont.semiBold,
        ),
      ),
      body: Center(
        child: Text("Rỗng"),
      ),
    );
  }
}
