import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromRGBO(164, 208, 235, 1),
    primary: Color.fromRGBO(202, 232, 250, 1),
    secondary: Color.fromRGBO(105, 165, 201, 1),
    inversePrimary: Color.fromRGBO(17, 47, 87, 1),
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: Color.fromRGBO(17, 47, 87, 1),
    displayColor: Color.fromRGBO(6, 18, 33, 1)
  )
);