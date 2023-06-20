import 'package:flutter/material.dart';

class ColorSelect {
  static Color importantColor = const Color(0xFFF85977);
  static Color primaryColor = const Color(0xFF5946D2);
  static Color primaryLightColor = const Color(0xFFC8BFFF);
  static Color lightPurpleBackground = const Color(0xFFB0A2F2);
  static Color darkPurple = const Color(0xFF988CD0);
  static Color grayColor = const Color(0xFF777679);
}

deleteBackground() {
  return Container(
    alignment: Alignment.centerRight,
    margin: EdgeInsets.all(4),
    padding: const EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      color: ColorSelect.importantColor,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    child: const Icon(Icons.delete_outline, color: Colors.white),
  );
}
