class WishlistItem {
  final String userId;
  final String productId;


  WishlistItem({
    required this.userId,
    required this.productId,

  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      userId: json['user_id'],
      productId: json['product_id'],

    );
  }
}
