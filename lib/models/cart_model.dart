class CartItem {
  final int userId;
  final int productId;
  final int quantity;

  CartItem({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['description'],
    );
  }
}
