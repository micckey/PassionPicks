class Product {
  final String id;
  final String name;
  final String description;
  final String price; // Change type to double
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      price: json['price'].toString(),
      image: json['image'].toString(),
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, image: $image}';
  }

}