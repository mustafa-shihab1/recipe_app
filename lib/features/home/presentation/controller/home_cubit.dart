import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../data/models/category_model.dart';
import '../../data/models/meal_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.client) : super(InitialHomeState());

  final http.Client client;

  /// Get Random Meal
  Future<void> getRandomMeal() async {
    emit(LoadingRandomMealState());

    try {
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.random),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final mealList = decodedJson['meals'] as List?;

        if (mealList != null && mealList.isNotEmpty) {
          final randomMeal = MealModel.fromJson(mealList.first);

          emit(LoadedRandomMealState(randomMeal));
        } else {
          emit(ErrorRandomMealState('No meal found!'));
        }
      } else {
        emit(
          ErrorRandomMealState(
            'Failed to load recipe (Error: ${response.statusCode})',
          ),
        );
      }
    } catch (error) {
      emit(ErrorRandomMealState('An error occurred: $error'));
    }
  }

  /// Get Categories
  Future<void> getCategories() async {
    emit(LoadingCategoriesState());

    try {
      final response = await client.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.categories),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final List<dynamic> categoriesList = decodedJson['categories'];

        final List<CategoryModel> categories = categoriesList
            .map((jsonCategory) => CategoryModel.fromJson(jsonCategory))
            .toList();

        emit(LoadedCategoriesState(categories));
      } else {
        emit(
          ErrorCategoriesState(
            'Failed to load categories (Error: ${response.statusCode})',
          ),
        );
      }
    } catch (e) {
      emit(
        ErrorCategoriesState("An error occurred while fetching categories: $e"),
      );
    }
  }
}
