class Transaction {
  final String? userId;
  final String productId;
  final String quantity;

  Transaction({
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  @override
  String toString() {
    return 'Transaction{userId: $userId, productId: $productId, quantity: $quantity}';
  }
}
