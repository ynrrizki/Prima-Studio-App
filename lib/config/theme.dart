import 'package:flutter/material.dart';

enum ThemeKeys { light, dark }

Color kPrimaryColor = Colors.orange;

class PrimaStudioThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: const Color.fromARGB(255, 232, 235, 240),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.orange,
      brightness: Brightness.light,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    highlightColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      focusColor: Colors.orangeAccent,
      splashColor: Colors.deepOrange,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    chipTheme: ChipThemeData(
      disabledColor: Colors.white,
      selectedColor: kPrimaryColor.withOpacity(0.1),
      checkmarkColor: kPrimaryColor,
      surfaceTintColor: kPrimaryColor,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: kPrimaryColor,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kPrimaryColor,
    highlightColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromARGB(255, 26, 27, 27),
    backgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: Colors.orange,
      brightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 26, 27, 27),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.orange,
      focusColor: Colors.orangeAccent,
      splashColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(selectionColor: Colors.grey),
    chipTheme: ChipThemeData(
      disabledColor: const Color.fromARGB(255, 26, 27, 27),
      selectedColor: kPrimaryColor.withOpacity(0.1),
      checkmarkColor: kPrimaryColor,
      surfaceTintColor: kPrimaryColor,
      backgroundColor: const Color.fromARGB(255, 26, 27, 27),
      side: BorderSide(
        color: kPrimaryColor,
      ),
    ),
  );

  static ThemeData getThemeFromKey(ThemeKeys themeKey) {
    switch (themeKey) {
      case ThemeKeys.light:
        return lightTheme;
      case ThemeKeys.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}
