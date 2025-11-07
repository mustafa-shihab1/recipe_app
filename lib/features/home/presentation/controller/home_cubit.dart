import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../data/models/category_model.dart';
import '../../data/models/meal_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.client) : super(HomeState());

  final http.Client client;

  /// Get Random Meal
  Future<void> getRandomMeal() async {
    emit(state.copyWith(randomMealStatus: RequestStatus.loading));

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

          emit(state.copyWith(
            randomMealStatus: RequestStatus.success,
            randomMeal: randomMeal,
          ));
        } else {
          emit(state.copyWith(
            randomMealStatus: RequestStatus.error,
            errorMessage: "No meal found.",
          ));
        }
      } else {
        emit(state.copyWith(
          randomMealStatus: RequestStatus.error,
          errorMessage: 'Failed to load recipe (Error: ${response.statusCode})',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        randomMealStatus: RequestStatus.error,
        errorMessage: "An error occurred: $e",
      ));
    }
  }

  /// Get Categories
  Future<void> getCategories() async {
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));

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

        emit(state.copyWith(
          categoriesStatus: RequestStatus.success,
          categories: categories,
        ));
      } else {
        emit(state.copyWith(
          categoriesStatus: RequestStatus.error,
          errorMessage: 'Failed to load categories (Error: ${response.statusCode})',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        categoriesStatus: RequestStatus.error,
        errorMessage: "An error occurred while fetching categories: $e",
      ));
    }
  }
}
