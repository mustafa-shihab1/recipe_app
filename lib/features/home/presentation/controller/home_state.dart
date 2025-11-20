import '../../data/models/category_model.dart';
import '../../data/models/meal_model.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingRandomMealState extends HomeState {}

class LoadedRandomMealState extends HomeState {
  MealModel meal;
  LoadedRandomMealState(this.meal);
}

class ErrorRandomMealState extends HomeState {
  final String message;
  ErrorRandomMealState(this.message);
}

class LoadingCategoriesState extends HomeState {}

class LoadedCategoriesState extends HomeState {
  List<CategoryModel> categories;
  LoadedCategoriesState(this.categories);
}

class ErrorCategoriesState extends HomeState {
  final String message;
  ErrorCategoriesState(this.message);
}
