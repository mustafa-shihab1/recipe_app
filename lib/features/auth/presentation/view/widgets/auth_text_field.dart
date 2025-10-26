import 'package:flutter/material.dart';

import '../../../../../core/resources/colors_manager.dart';

class AuthTextField extends StatelessWidget {
  final bool obscureText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const AuthTextField({
    super.key,
    this.obscureText = false,
    required this.hintText,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorsManager.errorBoxColor,
            width: 2
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ColorsManager.errorBoxColor,
              width: 2

          ),
        ),
        filled: true,
        fillColor: ColorsManager.secondaryColor,

      ),

    );
  }
}
