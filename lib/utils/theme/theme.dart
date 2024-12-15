import 'package:e_commercial_app/utils/theme/custom_Themes/appbar_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/bottom_sheet_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/checkbox_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/chip_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/elevated_button_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/outlined_button_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/text_field_theme.dart';
import 'package:e_commercial_app/utils/theme/custom_Themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme{ // T = Custom widgets/functionality
  TAppTheme._(); //NOT MANDATORY

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckboxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF272727),
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckboxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme
  );
}