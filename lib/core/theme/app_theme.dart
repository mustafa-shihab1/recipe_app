import 'package:flutter/material.dart';
import '../../core/resources/colors_manager.dart';

import 'custom_text_theme.dart';
import 'custom_appbar_theme.dart';
import 'custom_chip_theme.dart';
import 'custom_elevated_button_theme.dart';
import 'custom_checkbox_theme.dart';
import 'custom_bottom_sheet_theme.dart';
import 'custom_outlined_button_theme.dart';
import 'custom_text_form_field_theme.dart';
import 'custom_icon_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'DMSans',
      primaryColor: ColorsManager.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: CustomTextTheme.lightTextTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
      chipTheme: CustomChipTheme.lightCustomChipTheme,
      appBarTheme: CustomAppBarTheme.lightAppBarTheme,
      checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
      iconTheme: CustomIconTheme.lightIconTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ColorsManager.primaryColor,
      scaffoldBackgroundColor: Colors.black,
      textTheme: CustomTextTheme.darkTextTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
      chipTheme: CustomChipTheme.darkCustomChipTheme,
      appBarTheme: CustomAppBarTheme.darkAppBarTheme,
      checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
      outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
      iconTheme: CustomIconTheme.darkIconTheme,
    );
  }
}
