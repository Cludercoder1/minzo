class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isFeatured;
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFeatured = false,
    this.rating = 0.0,
    this.stock = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? '',
      isFeatured: json['is_featured'] == 1 || json['is_featured'] == true,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      stock: int.tryParse(json['stock'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category': category,
      'is_featured': isFeatured,
      'rating': rating,
      'stock': stock,
    };
  }
}