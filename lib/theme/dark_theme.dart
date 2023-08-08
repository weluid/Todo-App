import 'package:flutter/material.dart';
import 'package:todo/utilities/constants.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: ColorSelect.darkGrayColor,
    secondary: ColorSelect.darkSecondaryColor,
    secondaryContainer: ColorSelect.darkSecondaryContainerColor,
    outline: ColorSelect.darkSecondaryGrayColor,
    outlineVariant: ColorSelect.outlinedPurple

  )
);
