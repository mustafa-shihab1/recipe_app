import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../routes/routes.dart';
import '../controller/home_cubit.dart';
import 'widgets/categories_section.dart';
import 'widgets/random_meal_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBgColor,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => instance<HomeCubit>()
            ..getRandomMeal()
            ..getCategories(),

          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome back, Mustafa!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorsManager.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      AssetsManager.notificationIcon,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Time to spice things up!',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 14),
              // create search box
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.searchView),
                child: AbsorbPointer(
                  // AbsorbPointer prevents the TextField from gaining focus
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for recipes...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                      prefixIcon: Image.asset(
                        AssetsManager.searchIcon,
                        color: ColorsManager.primaryColor,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Meal of the Moment",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              RandomMealWidget(),

              const SizedBox(height: 30),

              Text(
                "Categories",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              CategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }
}
