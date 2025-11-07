import '../../data/models/category_model.dart';
import '../../data/models/meal_model.dart';

enum RequestStatus { initial, loading, success, error }

class HomeState {
  final RequestStatus randomMealStatus;
  final MealModel? randomMeal;

  final RequestStatus categoriesStatus;
  final List<CategoryModel>? categories;

  final String? errorMessage;

  HomeState({
    this.randomMealStatus = RequestStatus.initial,
    this.randomMeal,
    this.categoriesStatus = RequestStatus.initial,
    this.categories,
    this.errorMessage,
  });

  HomeState copyWith({
    RequestStatus? randomMealStatus,
    MealModel? randomMeal,
    RequestStatus? categoriesStatus,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) {
    return HomeState(
      randomMealStatus: randomMealStatus ?? this.randomMealStatus,
      randomMeal: randomMeal ?? this.randomMeal,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
