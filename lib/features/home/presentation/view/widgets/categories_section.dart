import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../routes/routes.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return current is LoadingCategoriesState ||
            current is LoadedCategoriesState ||
            current is ErrorCategoriesState;
      },
      listener: (context, state) => {},
      builder: (context, state) {
        if (state is LoadingCategoriesState) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is ErrorCategoriesState) {
          return Center(
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 60),
                const SizedBox(height: 10),
                Text(state.message),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.read<HomeCubit>().getCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is LoadedCategoriesState) {
          final categories = state.categories!;

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.categoryRecipesView,
                    arguments: category.strCategory,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Category Image
                        Positioned.fill(
                          child: Image.network(
                            category.strCategoryThumb,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.18),
                          ),
                        ),
                        // Category Name
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Text(
                            category.strCategory,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
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
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
