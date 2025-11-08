import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/storage/local/database/controller/recipe_database_controller.dart';
import '../../../../core/storage/local/database/model/recipe.dart';
import 'add_recipe_state.dart';

class AddRecipeCubit extends Cubit<AddRecipeState> {
  // Corrected dependency to use your RecipeDatabaseController
  final RecipeDatabaseController _recipeDatabaseController;

  AddRecipeCubit(this._recipeDatabaseController)
    : super(AddRecipeInitialState());

  XFile? recipePickedImage;

  Future<void> pickRecipeImage() async {
    recipePickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (recipePickedImage == null) return;
    emit(AddRecipeImagePickedState(recipePickedImage!));
  }

  /// Adds a new recipe to the local database.
  Future<void> insertRecipe(Recipe recipe) async {
    try {
      await _recipeDatabaseController.insertRecipeToDb(recipe);
      print('Recipe inserted successfully!');
      emit(AddRecipeSuccessState());
    } catch (e) {
      emit(AddRecipeErrorState(e.toString()));
    }
  }
}
