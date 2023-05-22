import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../viewmodel/cart_viewmodel.dart';

class ACartItem extends StatelessWidget {
  const ACartItem({
    this.prodId,
    required this.id,
    required this.price,
    required this.thumbnail,
    required this.quantity,
    required this.title,
  });

  final String? id;
  final String? prodId;
  final double price;
  final int quantity;
  final String title;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: const Icon(Icons.delete_sweep),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<CartViewModel>(context, listen: false).removeItem(prodId);
      },
      confirmDismiss: (direcion) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: Text(
                "Do you want to remove ${title.toUpperCase()} from the cart? "),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes", style: TextStyle(fontSize: 20)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No", style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Provider.of<CartViewModel>(context, listen: false)
              .removeSingleItem(prodId);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(thumbnail),
              title: Text(title.toString()),
              subtitle: Text("Total: ${price * quantity}"),
              trailing: Text("${quantity}x"),
            ),
          ),
        ),
      ),
    );
  }
}
