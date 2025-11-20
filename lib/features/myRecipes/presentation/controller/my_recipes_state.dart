abstract class MyRecipesState {}

class MyRecipesInitialState extends MyRecipesState {}

class MyRecipesLoadingState extends MyRecipesState {}

class MyRecipesSuccessState extends MyRecipesState {}

class MyRecipesErrorState extends MyRecipesState {
  final String message;
  MyRecipesErrorState(this.message);
}
