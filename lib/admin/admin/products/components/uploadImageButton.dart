import 'package:flutter/material.dart';
class DynamicImageUploadButton extends StatelessWidget {
  final String textLabel;
  final int index;
  final Function(int) selectImage;

  DynamicImageUploadButton({
    required this.textLabel,
    required this.index,
    required this.selectImage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => selectImage(index),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.upload),
          SizedBox(width: 8),
          Text(textLabel),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


