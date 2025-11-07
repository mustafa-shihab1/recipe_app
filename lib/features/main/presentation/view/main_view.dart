import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/colors_manager.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../addRecipe/presentation/view/add_recipe_view.dart';
import '../controller/main_cubit.dart';
import '../controller/main_state.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is MainTabChangedState) {
          currentIndex = state.currentIndex;
        }

        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorsManager.scaffoldBgColor,
            body: IndexedStack(
              index: currentIndex,
              children: context.read<MainCubit>().screens,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorsManager.primaryColor,
              elevation: 4,
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecipeView(),));
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


            bottomNavigationBar: BottomNavBar(

              currentIndex: currentIndex,
              onTap: (index) => context.read<MainCubit>().changeBottomNav(index),
              icons: context.read<MainCubit>().icons,
              labels: context.read<MainCubit>().labels,
            ),
          ),
        );
      },
    );
  }
}
