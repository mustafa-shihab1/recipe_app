import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependency_injection.dart';
import '../../../../core/resources/colors_manager.dart';
import '../controller/favorites_cubit.dart';
import '../controller/favorites_state.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<FavoritesCubit>()..getFavoriteRecipes(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorites',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: ColorsManager.primaryColor,
            ),
          ),
          centerTitle: true,
          leading: SizedBox(),
        ),
        body: BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<FavoritesCubit>();
            if (state is LoadedFavoritesState && state.favorites.isEmpty) {
              return  Center(
                child: Text("No favorite recipes yet. Start adding some!", style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),),
              );
            } else {}

            return state is LoadedFavoritesState
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: state.favorites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final meal = state.favorites[index];

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {},
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
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                                child: Image.file(
                                  File(meal.imagePath),
                                  width: 120,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meal.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      meal.category,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.restaurant_menu,
                                          size: 16,
                                          color: Colors.grey.shade700,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${meal.area} Cuisine",
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
                              // favorite icon
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: ColorsManager.primaryColor,
                                  ),
                                  onPressed: () {
                                    cubit.removeRecipeFromFavorites(
                                      cubit.favorites[index].id,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
