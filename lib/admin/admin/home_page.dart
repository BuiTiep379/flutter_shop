import 'package:flutter/material.dart';
import '../utils/text_custom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './base_page.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class HomePageScreen extends BasePage {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends BasePageState<HomePageScreen> {
  final List<List<Color>> _rainbowColors = [
    [Colors.red, Colors.orange, Colors.yellow],
    [Colors.green, Colors.blue, Colors.purple],
    [Colors.pink, Colors.amber, Colors.teal],
    [Colors.deepPurple, Colors.lightBlue, Colors.lime],
  ];
  bool _isLoading = true;
  int _productCount = 0;
  int _categoryCount = 0;
  int _userCount = 0;
  int _orderCount = 0;
  @override
  void initState() {
    super.initState();
    pageTitle = "Dashboard";
    _fetchData();
  }

  Future<void> _fetchData() async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final categoryCollection =
        FirebaseFirestore.instance.collection('categories');
    final userCollection = FirebaseFirestore.instance.collection('users');
    final orderCollection = FirebaseFirestore.instance.collection('orders');

    final productCount =
        await productCollection.get().then((snapshot) => snapshot.size);
    final categoryCount =
        await categoryCollection.get().then((snapshot) => snapshot.size);
    final userCount =
        await userCollection.get().then((snapshot) => snapshot.size);
    final orderCount =
        await orderCollection.get().then((snapshot) => snapshot.size);
    print(productCount);
    setState(() {
      _productCount = productCount;
      _categoryCount = categoryCount;
      _userCount = userCount;
      _orderCount = orderCount;
      _isLoading = false;
    });
  }

  @override
  Widget pageUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCard(
                  icon: Icons.shopping_cart,
                  title: 'Products',
                  value: '$_productCount',
                  backgroundColors: _rainbowColors[0],
                ),
                _buildCard(
                  icon: Icons.category,
                  title: 'Categories',
                  value: '$_categoryCount',
                  backgroundColors: _rainbowColors[1],
                ),
                _buildCard(
                  icon: Icons.person,
                  title: 'Users',
                  value: '$_userCount',
                  backgroundColors: _rainbowColors[2],
                ),
                _buildCard(
                  icon: Icons.assignment,
                  title: 'Orders',
                  value: '$_orderCount',
                  backgroundColors: _rainbowColors[3],
                ),
              ],
            ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
    required List<Color> backgroundColors,
  }) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Handle card tap
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgroundColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48.0, color: Colors.white),
                const SizedBox(height: 16.0),
                CustomText(
                    text: title,
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                const SizedBox(height: 8.0),
                CustomText(
                    text: value,
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
