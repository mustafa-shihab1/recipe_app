import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependency_injection.dart';
import '../../../../core/storage/local/database/controller/recipe_database_controller.dart';
import '../../../../core/storage/local/database/model/recipe.dart';
import '../../../MyRecipes/presentation/controller/my_recipes_cubit.dart';
import 'recipe_details_state.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._recipeDatabaseController)
    : super(RecipeDetailsInitialState());

  final RecipeDatabaseController _recipeDatabaseController;

  final bool isFavorite = false;

  // Future<void> addToFavorites(Recipe recipe) async {
  //   try {
  //     await _recipeDatabaseController.addRecipeToFavorites(recipe);
  //     print('Recipe added to favorites successfully!');
  //     emit(RecipeAddedToFavoritesState());
  //   } catch (e) {
  //     emit(RecipeDetailsErrorState(e.toString()));
  //   }
  // }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      await _recipeDatabaseController.updateRecipeFromDb(recipe);
      print('Recipe updated successfully!');
      emit(RecipeUpdatedState());
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }

  Future<void> deleteRecipe(int recipeId) async {
    try {
      await _recipeDatabaseController.deleteRecipeFromDb(recipeId);
      print('Recipe deleted successfully!');
      emit(RecipeDeletedState());
    } catch (e) {
      emit(RecipeDetailsErrorState(e.toString()));
    }
  }
}
