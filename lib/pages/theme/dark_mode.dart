import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary:Color.fromRGBO(6, 18, 33, 1),
      secondary: Color.fromRGBO(17, 47, 87, 1),
      inversePrimary: Color.fromRGBO(164, 208, 235, 1),
    ),
    textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Color.fromRGBO(164, 208, 235, 1),
        displayColor: Colors.white
    )
);