import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shop_shoes/src/const/app_colors.dart';
import 'package:flutter_shop_shoes/src/view/screen/cart_tab.dart';
import 'package:flutter_shop_shoes/src/view/screen/category_tab.dart';
import 'package:flutter_shop_shoes/src/view/screen/favorite_tab.dart';
import 'package:flutter_shop_shoes/src/view/screen/personal_tab.dart';

import 'package:flutter_shop_shoes/src/viewmodel/bottom_navigate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../theme/custom_colors_theme.dart';
import 'home_tab.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with TickerProviderStateMixin {
  List<Widget> page = [
    CategoryTab(),
    FavoriteTab(),
    CartTab(),
    PersonalTab(),
    HomeTab(),
  ];

  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.category,
    Icons.favorite,
    Icons.shopping_bag,
    Icons.person,
  ];
  final nameList = [
    "Category",
    "Favorite",
    "Cart",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;

    var bottomProvider =
        Provider.of<BottomNavigationProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      // body: page[bottomProvider.currentIndex],
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(12),
      //     topLeft: Radius.circular(12),
      //   ),
      //   child:

      //   BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     unselectedItemColor: AppColors.primaryColorGray,
      //     selectedItemColor: AppColors.primaryColorRed,
      //     currentIndex: bottomProvider.currentIndex,
      //     onTap: (int index) {
      //       bottomProvider.changePageTab = index;
      //     },
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: bottomProvider.currentIndex != 0
      //             ? SvgPicture.asset('assets/image/home_inactive.svg')
      //             : SvgPicture.asset('assets/image/home_active.svg'),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: bottomProvider.currentIndex != 1
      //             ? SvgPicture.asset('assets/image/categories_inactive.svg')
      //             : SvgPicture.asset('assets/image/categories_active.svg'),
      //         label: 'Category',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: bottomProvider.currentIndex != 2
      //             ? SvgPicture.asset('assets/image/bag_inactive.svg')
      //             : SvgPicture.asset('assets/image/bag_active.svg'),
      //         label: 'Cart',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: bottomProvider.currentIndex != 3
      //             ? SvgPicture.asset('assets/image/hear_inactive.svg')
      //             : SvgPicture.asset('assets/image/hear_active.svg'),
      //         label: 'Favorite',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: bottomProvider.currentIndex != 4
      //             ? SvgPicture.asset('assets/image/profile_inactive.svg')
      //             : SvgPicture.asset('assets/image/profile_active.svg'),
      //         label: 'Personal',
      //       ),
      //     ],
      //   ),
      // ),

      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: page[bottomProvider.currentIndex],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.home,
          color:
              bottomProvider.currentIndex == 4 ? Colors.yellow : Colors.white,
        ),
        onPressed: () {
          bottomProvider.changePageTab = 4;
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = index == bottomProvider.currentIndex
              ? Colors.yellow
              : Colors.white;
          return ElevatedButton(
            style: ButtonStyle(
                // shape: MaterialStateProperty.all<OutlinedBorder>(
                //     RoundedRectangleBorder(
                //         side: BorderSide(width: 0.0, color: Colors.orange),
                //         borderRadius: BorderRadius.circular(5.0))),
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange)),
            onPressed: () {
              bottomProvider.changePageTab = index;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    nameList[index],
                    maxLines: 1,
                    style: TextStyle(color: color),
                    group: autoSizeGroup,
                  ),
                )
              ],
            ),
          );
        },
        backgroundColor: Colors.orange,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.yellow,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        // shadow: BoxShadow(
        //   offset: Offset(0, 1),
        //   blurRadius: 12,
        //   spreadRadius: 0.5,
        //   color: Colors.yellow,
        // ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          SizedBox(height: 64),
          Center(
            child: CircularRevealAnimation(
              animation: animation,
              centerOffset: Offset(80, 80),
              maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
              child: Icon(
                widget.iconData,
                color: colors.activeNavigationBarColor,
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
