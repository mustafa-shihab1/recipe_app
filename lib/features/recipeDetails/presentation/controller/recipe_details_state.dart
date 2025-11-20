import 'package:image_picker/image_picker.dart';

import '../../../../core/storage/local/database/model/recipe.dart';

abstract class RecipeDetailsState {}

class RecipeDetailsInitialState extends RecipeDetailsState {}

class RecipeUpdatedState extends RecipeDetailsState {
  final Recipe updatedRecipe;
  RecipeUpdatedState(this.updatedRecipe);

}

class RecipeImagePickedState extends RecipeDetailsState {
  final XFile pickedImage;
  RecipeImagePickedState(this.pickedImage);
}

class RecipeDeletedState extends RecipeDetailsState {}

class RecipeAddedToFavoritesState extends RecipeDetailsState {}

class RecipeRemovedFromFavoritesState extends RecipeDetailsState {}

class RecipeDetailsErrorState extends RecipeDetailsState {
  final String message;

  RecipeDetailsErrorState(this.message);
}
