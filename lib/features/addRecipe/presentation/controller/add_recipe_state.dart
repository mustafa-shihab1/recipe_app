import 'package:image_picker/image_picker.dart';

abstract class AddRecipeState {}

class AddRecipeInitialState extends AddRecipeState {}

class AddRecipeSuccessState extends AddRecipeState {
  AddRecipeSuccessState();
}

class AddRecipeLoadingState extends AddRecipeState {}

class AddRecipeErrorState extends AddRecipeState {
  final String error;
  AddRecipeErrorState(this.error);
}

class AddRecipeImagePickedState extends AddRecipeState {
  final XFile pickedImage;
  AddRecipeImagePickedState(this.pickedImage);
}
