import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String label;
  final String textLabel;
  final dynamic selectedValue;
  final List<String> itemList;
  final IconData icon;
  

  const CustomDropdownButtonFormField({
    Key? key,
    required this.label,
    required this.textLabel,
    required this.selectedValue,
    required this.itemList,
    required this.icon,
  }) : super(key: key);

  @override
  _CustomDropdownButtonFormFieldState createState() =>
      _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  dynamic _selectedValue;

   @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue; // set initial value
  } 
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedValue,
      items: widget.itemList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },

      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon:
            Icon(color: Colors.deepPurple, widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return '${widget.textLabel} is required';
        }
      },
    );
  }
}
