class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantity; // إضافة خاصية الكمية

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity = 1, // قيمة افتراضية تساوي 1
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image'] ?? json['imageUrl'] ?? '',
      quantity: 1,
    );
  }
}