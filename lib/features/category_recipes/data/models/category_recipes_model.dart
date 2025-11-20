
class CategoryRecipesModel {
  final String id;
  final String name;
  final String thumbnail;

  const CategoryRecipesModel({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory CategoryRecipesModel.fromJson(Map<String, dynamic> json) {
    return CategoryRecipesModel(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
    );
  }

}
