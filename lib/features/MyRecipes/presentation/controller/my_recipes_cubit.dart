import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/local/database/controller/recipe_database_controller.dart';
import '../../../../core/storage/local/database/model/recipe.dart';
import 'my_recipes_state.dart';

class MyRecipesCubit extends Cubit<MyRecipesState> {
  MyRecipesCubit(this._recipeDatabaseController)
    : super(MyRecipesInitialState());

  final RecipeDatabaseController _recipeDatabaseController;
  List<Recipe> recipes = [];

  Future<void> getSavedRecipe() async {
    try {
      recipes = await _recipeDatabaseController.getRecipesFromDb();
      print('Recipes retrieved successfully!');
      emit(MyRecipesSuccessState());
    } catch (e) {
      emit(MyRecipesErrorState(e.toString()));
    }
  }
}
