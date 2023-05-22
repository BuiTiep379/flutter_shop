import 'package:flutter/material.dart';
import '../utils/text_custom.dart';
import 'package:flutter_shop_shoes/admin/admin/categories/category_list_screen.dart';
import 'package:flutter_shop_shoes/admin/admin/users/user_list_screen.dart';
import './home_page.dart';
import 'products/product_list_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import './orders/list_order_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class NavbarModel {
  String title;
  IconData icon;
  Color color;

  NavbarModel(this.title, this.icon, this.color);
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<NavbarModel> titleList = [
    NavbarModel("Dashboard", Icons.home, Colors.blue),
    NavbarModel("Users", Icons.people, Colors.orange),
    NavbarModel("Categories", Icons.category, Colors.pink),
    NavbarModel("Products", Icons.image, Colors.green),
    NavbarModel("Orders", Icons.shopping_basket, Colors.deepPurpleAccent),
  ];
  int _index = 0;

  List<Widget> listWidget = [
    HomePageScreen(),
    UserListScreen(),
    CategoryListScreen(),
    ProductListScreen(),
    OrderListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          items: titleList
              .map(
                (item) => SalomonBottomBarItem(
                  icon: Icon(item.icon),
                  title: CustomText(
                      text: item.title,
                      color: Colors.cyan,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  selectedColor: Colors.cyan,
                ),
              )
              .toList(),
        ),
        body: listWidget[_index]);
  }
}
