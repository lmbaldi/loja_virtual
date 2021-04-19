import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final primaryColor = const Color.fromARGB(255, 4, 125, 141);

  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: const AppBarTheme(elevation: 0),
  );
}