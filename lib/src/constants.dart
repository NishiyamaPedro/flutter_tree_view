import 'package:flutter/material.dart';

class ExtraColors {
  static const Color darkBlue = Color.fromARGB(255, 23, 25, 45);
}

class CustomTheme {
  static ColorScheme colorScheme =
      ColorScheme.fromSeed(seedColor: ExtraColors.darkBlue);
  static ThemeData theme = ThemeData(
    colorScheme: CustomTheme.colorScheme,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (BuildContext context) =>
          const Icon(Icons.arrow_back_ios_new_rounded),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ExtraColors.darkBlue,
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.0),
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: CustomTheme.colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      showCheckmark: false,
      side: BorderSide(
        color: CustomTheme.colorScheme.surfaceContainerHighest,
      ),
    ),
  );
}
