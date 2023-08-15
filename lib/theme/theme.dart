import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    unselectedWidgetColor: ColorSelect.darkSecondaryGrayColor,
    colorScheme: ColorScheme.dark(
      background: ColorSelect.darkGrayColor,
      secondary: ColorSelect.darkSecondaryColor,
      secondaryContainer: ColorSelect.darkSecondaryContainerColor,
      outline: ColorSelect.darkSecondaryGrayColor,
      outlineVariant: ColorSelect.outlinedPurple,
      primary: ColorSelect.primaryColor,
    ));

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    unselectedWidgetColor: ColorSelect.grayColor,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      secondary: ColorSelect.lightPurpleBackground,
      secondaryContainer: ColorSelect.darkPurple,
      outline: ColorSelect.darkSecondaryGrayColor,
      outlineVariant: ColorSelect.primaryColor,
      primary: ColorSelect.primaryColor,
    ));
