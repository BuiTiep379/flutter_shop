import 'package:flutter_shop_shoes/src/data/model/product.dart';
import 'package:flutter/material.dart';

import '../../service/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  ProductService? productService = ProductService();
  List<Product>? listProduct;
  List<Product>? listRecent = <Product>[];
  bool isLoading = false;
  int? isLikee = 0;
  int selectIndex = 0;
  Product? productt;

  Future<List<Product>>? getListProduct() {
    isLoading = true;
    notifyListeners();
    // listProduct = productService?.listProduct;
    isLoading = false;
    notifyListeners();
  }

  Future likeProduct(Product product) async {
    print(product.name);
    // productt?.isLike = product.isLike;
    // if(productt?.isLike == 0){
    //   productt?.isLike = 1;
    //  notifyListeners();
    // }
    // var a = listProduct?.indexWhere((element) => element.id == product.id);
    // if(a != -1){
    //   listProduct?[a].isLike = isLikee  = 1;
    //
    //   notifyListeners();
    // }
  }

  addRecentView(Product product) {
    if (listRecent!.isEmpty) {
      listRecent?.add(product);
    } else {
      if (listRecent!.contains(product)) {
      } else {
        listRecent?.add(product);
      }
    }
  }

  chooseOption(int index) {
    selectIndex = index;
    notifyListeners();
  }
}
