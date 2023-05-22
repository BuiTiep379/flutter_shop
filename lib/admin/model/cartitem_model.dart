//


class CartItem {
  final String title;
  final String id;
  final String thumbnail;
  final int quantity;
  final double price;
  final String color;
  final String size;

  CartItem({
    required this.title,
    required this.id,
    required this.thumbnail,
    required this.quantity,
    required this.price,
    required this.color,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'price': price,
      'color': color,
      'size': size
    };
  }
  CartItem.fromMap(Map<String, dynamic> cartItemMap)
      : title = cartItemMap["title"],
        id = cartItemMap["id"],
        thumbnail = cartItemMap["thumbnail"],
        quantity = cartItemMap["quantity"],
        price = cartItemMap["price"].toDouble(),
        color = cartItemMap["color"],
        size = cartItemMap["size"];

}

 
