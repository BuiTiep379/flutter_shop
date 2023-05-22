import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/view/screen/checkout_screen.dart';
import 'package:flutter_shop_shoes/src/viewmodel/cart_viewmodel.dart';
import 'package:page_transition/page_transition.dart';

import '../data/model/product.dart';
import '../view/screen/add_address_screen.dart';
import '../view/screen/change_pass_screen.dart';
import '../view/screen/choice_address_screen.dart';
import '../view/screen/component/otp_screen.dart';
import '../view/screen/detail_product_screen.dart';
import '../view/screen/forgot_pass_screen.dart';
import '../view/screen/order_success_screen.dart';
import '../view/screen/recent_view_screen.dart';
import '../view/screen/splash_screen.dart';

class Routerr {
  static RouteFactory onGenerateRouter = (RouteSettings settings) {
    switch (settings.name) {
      case DetailProductScreens:
        final arg = settings.arguments! as Product;
        return _generateMaterialRoute(DetailProductScreen(
          product: arg,
        ));
      case CheckoutScreens:
        return _generateMaterialRoute(CheckoutScreen());
      case ChoiceAddressScreens:
        return _generateMaterialRoute(ChoiceAddressScreen());
      case AddAddressScreens:
        return _generateMaterialRoute(AddAddressScreen());
      case OrderSuccessScreens:
        return _generateMaterialRoute(OrderSuccessScreen());

      // case OrderDetailScreens:
      //   final arg = settings.arguments! as Order;
      //   return _generateMaterialRoute(OrderDetailScreen(
      //     order: arg,
      //   ));
      case RecentViewScreens:
        final arg = settings.arguments! as List<Product>;
        return _generateMaterialRoute(RecentViewScreen(
          listRecentProduct: arg,
        ));
      case SplashScreens:
        return _generateMaterialRoute(SplashScreen());

      case ForgotPassScreens:
        return _generateMaterialRoute(ForgotPassScreen());
      case ChangePassScreens:
        return _generateMaterialRoute(ChangePassScreen());
      case OtpScreens:
        return _generateMaterialRoute(OtpScreen());
      default:
        return _generateMaterialRoute(Center(
          child: Text(
            "On Unknown Router",
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
            ),
          ),
        ));
    }
  };
}

PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(child: screen, type: PageTransitionType.fade);
}
