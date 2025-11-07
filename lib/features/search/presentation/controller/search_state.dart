import '../../../home/data/models/meal_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<MealModel> meals;

  SearchSuccessState(this.meals);
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}
