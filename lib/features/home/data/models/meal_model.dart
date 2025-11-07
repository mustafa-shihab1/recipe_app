class MealModel {

  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final bool isFavorite;

  const MealModel({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.isFavorite = false,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'] as String? ?? '',
      strMeal: json['strMeal'] as String? ?? '',
      strCategory: json['strCategory'] as String? ?? '',
      strArea: json['strArea'] as String? ?? '',
      strInstructions: json['strInstructions'] as String? ?? '',
      strMealThumb: json['strMealThumb'] as String? ?? '',
    );
  }
}
