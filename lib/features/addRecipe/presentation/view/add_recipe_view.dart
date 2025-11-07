import 'package:flutter/material.dart';

class AddRecipeView extends StatelessWidget {
  const AddRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: const Center(
        child: Text('Add Recipe View'),
      ),
    );
  }
}
