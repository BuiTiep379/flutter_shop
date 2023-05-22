import 'package:flutter/material.dart';
import '../utils/text_custom.dart';
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  String pageTitle = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0), // Set your custom color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0, // 1
        title: Center(child: CustomText(text: this.pageTitle, fontWeight: FontWeight.bold, fontSize: 20.0)),
        
      ),
      body: pageUI(),
    );
  }

  Widget pageUI() {
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
