abstract class RecipeDetailsState {}

class RecipeDetailsInitialState extends RecipeDetailsState {}

class RecipeUpdatedState extends RecipeDetailsState {}

class RecipeDeletedState extends RecipeDetailsState {}

class RecipeAddedToFavoritesState extends RecipeDetailsState {}

class RecipeDetailsErrorState extends RecipeDetailsState {
  final String message;

  RecipeDetailsErrorState(this.message);
}
