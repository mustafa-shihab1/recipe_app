class CategoryModel {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  const CategoryModel({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      idCategory: json['idCategory'] as String? ?? '',
      strCategory: json['strCategory'] as String? ?? '',
      strCategoryThumb: json['strCategoryThumb'] as String? ?? '',
      strCategoryDescription: json['strCategoryDescription'] as String? ?? '',
    );
  }

}
