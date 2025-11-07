class Recipe {
  final int? id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imagePath;
  final bool isFavorite;

  Recipe({
    this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imagePath,
    this.isFavorite = false,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      area: map['area'],
      instructions: map['instructions'],
      imagePath: map['image'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'area': area,
      'instructions': instructions,
      'image': imagePath,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }
}
