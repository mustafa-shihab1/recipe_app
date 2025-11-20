import '../../data/models/category_recipes_model.dart';

abstract class CategoryRecipesState {
  const CategoryRecipesState();
}

class CategoryRecipesInitial extends CategoryRecipesState {}

class CategoryRecipesLoading extends CategoryRecipesState {}

class CategoryRecipesLoaded extends CategoryRecipesState {
  final List<CategoryRecipesModel> meals;

  const CategoryRecipesLoaded(this.meals);
}

class AddToFavoritesState extends CategoryRecipesState {
  final bool isFavorite;

  AddToFavoritesState(this.isFavorite);
}

class CategoryRecipesError extends CategoryRecipesState {
  final String message;

  const CategoryRecipesError(this.message);
}
