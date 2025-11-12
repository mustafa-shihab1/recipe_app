import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/favorites/presentation/controller/favorites_state.dart';

import '../../../../core/storage/local/database/controller/recipe_database_controller.dart';
import '../../../../core/storage/local/database/model/recipe.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._recipeDatabaseController)
    : super(InitialFavoritesState());

  final RecipeDatabaseController _recipeDatabaseController;

  List<Recipe> favorites = [];

  Future<void> getFavoriteRecipes() async {
    try {
      favorites = await _recipeDatabaseController.getFavoriteRecipesFromDb();
      print('Favorites retrieved successfully! (${favorites.length} items)');

      emit(LoadedFavoritesState(favorites));
    } catch (e) {
      emit(ErrorFavoritesState(e.toString()));
    }
  }

  Future<void> removeRecipeFromFavorites(int? id) async {
    try {
      await _recipeDatabaseController.removeFromFavorites(id!);
      print('Recipe Removed successfully from Favorites!');
      await getFavoriteRecipes();
      emit(LoadedFavoritesState(favorites));
    } catch (e) {
      emit(ErrorFavoritesState(e.toString()));
    }
  }
}
