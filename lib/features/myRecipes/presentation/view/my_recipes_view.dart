import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependency_injection.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../routes/routes.dart';
import '../controller/my_recipes_cubit.dart';
import '../controller/my_recipes_state.dart';

class MyRecipesView extends StatelessWidget {
  const MyRecipesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<MyRecipesCubit>()..getSavedRecipe(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Recipes',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: ColorsManager.primaryColor,
            ),
          ),
          leading: SizedBox(),
          centerTitle: true,
        ),
        body: BlocConsumer<MyRecipesCubit, MyRecipesState>(
          listener: (context, state) => {},
          builder: (context, state) {
            final cubit = context.read<MyRecipesCubit>();
            return cubit.recipes.length!=0? ListView.builder(
              itemCount: cubit.recipes.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () async{
                    final result  = await Navigator.pushNamed(
                      context,
                      Routes.recipeDetailsView,
                      arguments: cubit.recipes[index],
                    );
                    if (result == true) {
                      context.read<MyRecipesCubit>().getSavedRecipe();  }// Refresh the list if recipe was updated                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Hero(
                            tag: 'recipeImage-${cubit.recipes[index].id}',
                            child: Image.file(
                              File(cubit.recipes[index].imagePath),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.recipes[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    '${cubit.recipes[index].category} | ${cubit.recipes[index].area}',
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ): Center(
              child: Text(
                'No saved recipes yet.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
