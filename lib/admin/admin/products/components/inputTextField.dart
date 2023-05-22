import 'package:flutter/material.dart';

class DynamicTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isNumber;

  const DynamicTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.isNumber,
  }) : super(key: key);

  @override
  _DynamicTextFormFieldState createState() => _DynamicTextFormFieldState();
}

class _DynamicTextFormFieldState extends State<DynamicTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '${widget.labelText} is required';
        }
      },
      keyboardType: widget.isNumber
          ? TextInputType.numberWithOptions(decimal: false)
          : TextInputType.text, 
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(color: Colors.deepPurple, widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
