import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/features/home/presentation/controller/home_state.dart';

import '../../../../config/dependency_injection.dart';
import '../../../../core/storage/local/database/controller/recipe_database_controller.dart';
import '../../../../core/storage/local/database/model/recipe.dart';
import '../../../myRecipes/presentation/controller/my_recipes_cubit.dart';
import '../../../favorites/presentation/controller/favorites_cubit.dart';
import 'recipe_details_state.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._recipeDatabaseController)
    : super(RecipeDetailsInitialState());

  final RecipeDatabaseController _recipeDatabaseController;

  bool isFavorite = false;
  XFile? recipePickedImage;

  void init(Recipe recipe) {
    isFavorite = recipe.isFavorite;
    _checkFavoriteStatus(recipe.id);
  }

  Future<void> _checkFavoriteStatus(int? id) async {
    if (id == null) return;
    final recipe = await _recipeDatabaseController.getRecipeById(id);
    if (recipe != null && recipe.isFavorite != isFavorite) {
      isFavorite = recipe.isFavorite;
      emit(RecipeUpdatedState(recipe));
    }
  }

  Future<void> pickRecipeImage() async {
    recipePickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (recipePickedImage == null) return;
    emit(RecipeImagePickedState(recipePickedImage!));
  }

  void favoritesStatusChanged(Recipe recipe) {
    isFavorite = !isFavorite;
    if (isFavorite) {
      addToFavorites(recipe);
    } else {
      removeRecipeFromFavorites(recipe.id);
    }
  }

  Future<void> addToFavorites(Recipe recipe) async {
    try {
      await _recipeDatabaseController.addRecipeToFavorites(recipe);
      instance<FavoritesCubit>().getFavoriteRecipes();
      print('Recipe added to favorites successfully!');
      emit(RecipeAddedToFavoritesState());
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }

  Future<void> removeRecipeFromFavorites(int? id) async {
    try {
      await _recipeDatabaseController.removeFromFavorites(id!);
      print('Recipe Removed successfully from Favorites!');
      instance<FavoritesCubit>().getFavoriteRecipes();
      emit(RecipeRemovedFromFavoritesState());
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _recipeDatabaseController.updateRecipeFromDb(recipe);
      print('Recipe updated successfully!');
      emit(RecipeUpdatedState(recipe));
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }

  Future<void> deleteRecipe(int recipeId) async {
    try {
      await _recipeDatabaseController.deleteRecipeFromDb(recipeId);
      print('Recipe deleted successfully!');
      instance<MyRecipesCubit>().getSavedRecipe();
      emit(RecipeDeletedState());
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }
}
