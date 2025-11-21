class Diamond {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double carat;
  final String cut;
  final String clarity;
  final String color;
  final double price;
  final String category; // e.g., 'engagement', 'earrings', 'necklace'
  bool isFavorite;

  Diamond({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.carat,
    required this.cut,
    required this.clarity,
    required this.color,
    required this.price,
    required this.category,
    this.isFavorite = false,
  });

  // Convert Diamond to Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'carat': carat,
      'cut': cut,
      'clarity': clarity,
      'color': color,
      'price': price,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  // Create Diamond from Map (JSON)
  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      carat: json['carat'],
      cut: json['cut'],
      clarity: json['clarity'],
      color: json['color'],
      price: json['price'],
      category: json['category'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
