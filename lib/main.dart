// @dart=2.9
// --no-sound-null-safety
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_shop_shoes/src/router/routerr.dart';
import 'package:flutter_shop_shoes/src/view/screen/all_product_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/bestsale_product_screen%20copy.dart';
import 'package:flutter_shop_shoes/src/view/screen/category_product_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/choice_address_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/dash_board_client_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/detail_product_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/edit_person_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/home_tab.dart';
import 'package:flutter_shop_shoes/src/view/screen/list_order.dart';
import 'package:flutter_shop_shoes/src/view/screen/login_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/note_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/order_success_screen.dart';
import 'package:flutter_shop_shoes/src/view/screen/register_screen.dart';
import 'package:flutter_shop_shoes/src/viewmodel/address_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/auth_viemodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/bottom_navigate_provider.dart';
import 'package:flutter_shop_shoes/src/viewmodel/cart_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/login_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/user_viewmodel.dart';
import 'package:flutter_shop_shoes/src/viewmodel/whislist_viewmodel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'admin/admin/categories/add_category_screen.dart';
import 'admin/admin/categories/category_list_screen.dart';
import 'admin/admin/categories/edit_category_screen.dart';
import 'admin/admin/dashboard_screen.dart';
import 'admin/admin/home_page.dart';
import 'admin/admin/products/add_product_screen.dart';
import 'admin/admin/products/product_list_screen.dart';
import 'admin/admin/users/user_list_screen.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //         apiKey: "AIzaSyCXfAnqS96Q2BqW2cZGuzDLHec2ZiowKtM",
  //         appId: "1:687590845115:android:8b60a792ffc45bc422579e",
  //         messagingSenderId: "",
  //         projectId: "fluttershoesshops"));
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDM4x-vRG0fAakGtUG_JYuU9KsWs_CML_Q",
          appId: "1:314873554248:android:ec5718a45e94a172583f7d",
          messagingSenderId: "",
          projectId: "projectfinal-abdf9"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var loginData = Provider.of<LoginViewModel>(context, listen: true);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
          ChangeNotifierProvider(create: (_) => CartViewModel()),
          ChangeNotifierProvider(create: (_) => AddressViewModel()),
          ChangeNotifierProvider(create: (_) => WishListViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(
              create: (_) => ProductViewModel()..getListProduct()),
          ChangeNotifierProvider(create: (_) => AuthViewModel())
        ],
        child: GetMaterialApp(
          // home: LoginViewModel().itemCount <= 0
          //     ? DashBoardClientScreen()
          //     : LoginViewModel()?.items?.values?.toList()[0]?.username !=
          //             "admin@gmail.com"
          //         ? DashBoardClientScreen()
          //         : DashboardScreen(),

          home: DashBoardClientScreen(),

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: Routerr.onGenerateRouter,
          getPages: [
            GetPage(name: '/product-detail', page: () => DetailProductScreen()),
            // GetPage(name: '/cart', page: () => ShoppingCartScreen()),
            GetPage(name: '/home', page: () => HomeTab()),
            GetPage(name: '/', page: () => DashBoardClientScreen()),
            GetPage(name: '/chooseaddress', page: () => ChoiceAddressScreen()),
            GetPage(name: '/register', page: () => RegisterScreen()),

            GetPage(name: '/login', page: () => LoginScreen()),
            GetPage(name: '/order-success', page: () => OrderSuccessScreen()),
            GetPage(name: '/order-fail', page: () => OrderSuccessScreen()),
            GetPage(name: '/list-order', page: () => ListOrderScreen()),
            GetPage(
                name: '/list-notifications', page: () => NotifycationScreen()),

            GetPage(
                name: '/category-product', page: () => CategoryProductScreen()),
            GetPage(name: '/all-product', page: () => AllProductScreen()),
            GetPage(name: '/best-saller', page: () => BestSalerProductScreen()),
            GetPage(name: '/edit-person', page: () => EditPersonScreen()),
            GetPage(name: '/', page: () => HomePageScreen()),
            GetPage(
                name: '/category/add', page: () => const AddCategoryScreen()),
            GetPage(name: '/category/edit', page: () => EditCategoryScreen()),
            GetPage(name: '/category', page: () => CategoryListScreen()),
            GetPage(name: "/users", page: () => UserListScreen()),
            GetPage(name: "/products", page: () => ProductListScreen()),
            GetPage(name: '/products/add', page: () => AddProductScreen()),
            GetPage(
                name: "/products/details", page: () => DetailProductScreen()),

            GetPage(name: "/dashboard-admin", page: () => DashboardScreen()),
            // Dynamic route
          ],
        ));
  }
}

int currentIndex = 0;

void navigateToScreens(int index) {
  currentIndex = index;
}
