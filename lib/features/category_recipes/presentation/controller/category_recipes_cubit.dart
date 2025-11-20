import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/constants/api_constants.dart';
import '../../data/models/category_recipes_model.dart';
import 'category_recipes_state.dart';

class CategoryRecipesCubit extends Cubit<CategoryRecipesState> {
  final http.Client client;

  CategoryRecipesCubit(this.client) : super(CategoryRecipesInitial());

  Future<void> fetchRecipesByCategory(String categoryName) async {
    emit(CategoryRecipesLoading());
    try {
      final response = await client.get(
        Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.filter}?c=$categoryName',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic>? mealsList = data['meals'];

        if (mealsList != null) {
          final meals = mealsList
              .map((json) => CategoryRecipesModel.fromJson(json))
              .toList();
          emit(CategoryRecipesLoaded(meals));
        } else {
          emit(const CategoryRecipesLoaded([]));
        }
      } else {
        emit(
          CategoryRecipesError(
            'Failed to load recipes. Status code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(CategoryRecipesError('An error occurred: ${e.toString()}'));
    }
  }
}
