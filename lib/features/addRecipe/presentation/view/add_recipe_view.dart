import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependency_injection.dart';
import '../../../../core/storage/local/database/model/recipe.dart';
import '../controller/add_recipe_cubit.dart';
import '../controller/add_recipe_state.dart';
import 'dart:io';

class AddRecipeView extends StatefulWidget {
  const AddRecipeView({super.key});

  @override
  State<AddRecipeView> createState() => _AddRecipeViewState();
}

class _AddRecipeViewState extends State<AddRecipeView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _areaController = TextEditingController();
  final _instructionsController = TextEditingController();
  // String? _imagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _areaController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance<AddRecipeCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add a New Recipe')),
        body: BlocConsumer<AddRecipeCubit, AddRecipeState>(
          listener: (context, state) {
            if (state is AddRecipeSuccessState) {
              Navigator.of(context).pop(); // Go back on success.
            } else if (state is AddRecipeErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
            }
          },
          builder: (context, state) {
            if (state is AddRecipeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    GestureDetector(
                      onTap: context.read<AddRecipeCubit>().pickRecipeImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        child: state is AddRecipeImagePickedState
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(state.pickedImage.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tap to select an image',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Recipe Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.local_dining),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name for the recipe.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _categoryController,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.category_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a category.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _areaController,
                            decoration: const InputDecoration(
                              labelText: 'Area / Cuisine',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.public_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an area or cuisine.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _instructionsController,
                      decoration: const InputDecoration(
                        labelText: 'Instructions',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.receipt_long_outlined),
                      ),
                      maxLines: 6,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide instructions for the recipe.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton.icon(
                      icon: const Icon(Icons.save_alt_outlined),
                      label: const Text('Save Recipe'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<AddRecipeCubit>();
                          if (cubit.recipePickedImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select an image for the recipe.',
                                ),
                              ),
                            );
                            return;
                          }
                          final newRecipe = Recipe(
                            name: _nameController.text,
                            category: _categoryController.text,
                            area: _areaController.text,
                            instructions: _instructionsController.text,
                            imagePath: cubit.recipePickedImage!.path,
                          );
                          print(
                            'New Recipe Image Path: ${newRecipe.imagePath}',
                          );
                          cubit.insertRecipe(newRecipe);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
