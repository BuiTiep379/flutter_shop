class MyOrder {
  final String username;
  final String status;
  final double total;
  final String orderId;

  MyOrder({
    required this.username,
    required this.status,
    required this.total,
    required this.orderId,
  });

  factory MyOrder.fromMap(Map<String, dynamic> data) {
    return MyOrder(
      username: data['username'],
      status: data['status'],
      total: data['total'],
      orderId: data['orderId'],
    );
  }
}

