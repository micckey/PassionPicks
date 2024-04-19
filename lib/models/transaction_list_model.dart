class TransactionList {
  final String transactionId;
  final String productId;
  final String name;
  final String price;
  final String quantity;
  final String description;
  final String image;
  final DateTime transactionDate;

  TransactionList({
    required this.transactionId,
    required this.productId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.transactionDate,
    required this.quantity,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      transactionId: json['transaction_id'].toString(),
      productId: json['product_id'].toString(),
      name: json['name'],
      price: json['price'].toString(),
      quantity: json['quantity'].toString(),
      description: json['description'],
      image: json['image'],
      transactionDate: DateTime.parse(json['transaction_date']),
    );
  }

  @override
  String toString() {
    return 'Transaction{transaction_id: $transactionId, product_id: $productId, name: $name, price: $price, quantity: $quantity, description: $description, image: $image, transaction_date: $transactionDate,}';
  }
}
