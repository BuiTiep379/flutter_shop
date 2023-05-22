import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  List<String> listImage = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage
          .map((e) => Image.asset(
                e,
                fit: BoxFit.cover))
          .toList(),
    );
  }
}
