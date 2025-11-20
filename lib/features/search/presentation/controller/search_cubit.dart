import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/api_constants.dart';
import '../../../home/data/models/meal_model.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.client) : super(SearchInitialState());

  final http.Client client;

  Future<void> searchByName(String mealName) async {
    if (mealName.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());

    try {
      final Uri url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.search}?s=$mealName',
      );

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body);
        final mealsList = decodedJson['meals'];

        if (mealsList != null) {
          final meals = mealsList
              .map<MealModel>((jsonMeal) => MealModel.fromJson(jsonMeal))
              .toList();
          emit(SearchSuccessState(meals));
        } else {
          emit(SearchSuccessState([]));
        }
      } else {
        emit(
          SearchErrorState(
            'Failed to perform search (HTTP ${response.statusCode})',
          ),
        );
      }
    } catch (e) {
      emit(SearchErrorState('An error occurred: ${e.toString()}'));
    }
  }
}
