import 'package:flutter/material.dart';
import 'dart:ui';
class CustomBackdrop extends StatelessWidget {
  final Widget frontLayer;
  final Widget backLayer;

  CustomBackdrop({required this.frontLayer, required this.backLayer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        backLayer,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        frontLayer,
      ],
    );
  }
}

