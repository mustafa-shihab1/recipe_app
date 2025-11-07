import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/config/dependency_injection.dart';
import 'package:recipe_app/features/search/presentation/controller/search_cubit.dart';
import 'package:recipe_app/features/search/presentation/controller/search_state.dart';

import '../../../../core/resources/colors_manager.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance<SearchCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                disposeSearch();
              },
              child: Icon(Icons.arrow_back_ios_new, color: ColorsManager.primaryColor,size: 14,),
            ),
          ),
          title: Builder(
            builder: (context) {
              return TextField(
                autofocus: true,
                onChanged: (query) {
                  context.read<SearchCubit>().searchByName(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search for any recipe...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                style: const TextStyle(fontSize: 18),
              );
            },
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            } else if (state is SearchSuccessState) {
              if (state.meals.isEmpty) {
                return const Center(
                  child: Text(
                    'No recipes found matching your search.',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: state.meals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final meal = state.meals[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                    },
                    child: Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: -3,
                            offset: const Offset(0, 6),
                            color: Colors.black.withOpacity(0.08),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Meal image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Hero(
                              tag: meal.idMeal,
                              child: Image.network(
                                meal.strMealThumb,
                                width: 120,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.strMeal,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    meal.strCategory,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                  const Spacer(),

                                  Row(
                                    children: [
                                      Icon(Icons.restaurant_menu,
                                          size: 16, color: Colors.grey.shade700),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${meal.strArea} Cuisine",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

            }
            return const Center(
              child: Text('Start typing to find delicious recipes!'),
            );
          },
        ),
      ),
    );
  }
}
