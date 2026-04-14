class DessertItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final String category;
  final List<String> tags;
  bool isFavorite;

  DessertItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.category,
    this.tags = const [],
    this.isFavorite = false,
  });

  // Helper to copy object
  DessertItem copyWith({bool? isFavorite}) {
    return DessertItem(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      category: category,
      tags: tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
