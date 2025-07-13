class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description': description,
    };
  }
}