
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/home_cubit.dart';
import '../../controller/home_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, next) =>
      prev.categoriesStatus != next.categoriesStatus,
      builder: (context, state) {
        switch (state.categoriesStatus) {
          case RequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.success:
            final categories = state.categories!;

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
                  final category = categories[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // Category Image
                        Positioned.fill(
                          child: Image.network(
                            category.strCategoryThumb,
                            fit: BoxFit.cover,
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
                  );
                },
              ),
            );
          case RequestStatus.error:
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 60),
                  const SizedBox(height: 10),
                  Text(state.errorMessage ??
                      'Failed to load categories'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeCubit>().getCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}