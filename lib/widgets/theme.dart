import 'package:flutter/material.dart';

const defualtStyleText = TextStyle(fontFamily: "iranYekan");

class MyAppThemeConfig {
  final primaryColor;
  final primaryVariant;
  final backgroundColor;
  final surfaceColor;
  final errorColor;
  final onError;
  final secondaryColor;
  final primaryTextColor;
  final secondaryTextColor;
  final onPrimary;
  final onSecondary;
  final onSurface;
  final onBackground;
  final brightness;
  final deviderColor;
  final shadow;

  MyAppThemeConfig.light()
      : primaryColor = const Color(0xff6200EE),
        primaryVariant = const Color(0xff3700B3),
        backgroundColor = const Color(0xffffffff),
        surfaceColor = const Color(0xffffffff),
        errorColor = const Color(0xffB00020),
        onError = Colors.white,
        secondaryColor = const Color(0xff03DAC6),
        primaryTextColor = const Color(0xff262A35),
        secondaryTextColor = const Color(0xffB3B6BE),
        onPrimary = Colors.white,
        onSecondary = Colors.black,
        onBackground = Colors.black,
        onSurface = Colors.black,
        brightness = Brightness.light,
        deviderColor = Colors.grey.shade300,
        shadow = Colors.black.withOpacity(0.1);

  MyAppThemeConfig.dark()
      : primaryColor = const Color(0xffBB86FC),
        primaryVariant = const Color(0xff3700B3),
        backgroundColor = const Color(0xff121212),
        surfaceColor = const Color(0xff121212),
        errorColor = const Color(0xffCF6679),
        onError = Colors.black,
        secondaryColor = const Color(0xff03DAC5),
        primaryTextColor = Colors.white,
        secondaryTextColor = const Color(0xffB3B6BE),
        onPrimary = Colors.black,
        onSecondary = Colors.black,
        onBackground = Colors.white,
        onSurface = Colors.white,
        brightness = Brightness.dark,
        deviderColor = Colors.grey.shade700,
        shadow = Colors.white.withOpacity(0.3);

  ThemeData getTheme() {
    return ThemeData(
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: defualtStyleText.apply(color: onPrimary),
      ),
      dividerTheme: DividerThemeData(
        color: deviderColor,
      ),
      fontFamily: "iranYekan",
      textTheme: TextTheme(
          titleSmall: defualtStyleText.apply(color: secondaryTextColor),
          bodyMedium: defualtStyleText.apply(color: primaryTextColor),
          bodySmall: defualtStyleText.apply(color: secondaryTextColor),
          titleLarge: defualtStyleText
              .copyWith(fontWeight: FontWeight.bold, fontSize: 18)
              .apply(color: primaryTextColor),
          labelLarge: defualtStyleText),
      brightness: brightness,
      primaryColor: primaryColor,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          )),
      dividerColor: deviderColor,
      scaffoldBackgroundColor: backgroundColor,
      // textTheme: languageCode == "en" ? enPrimaryTextTheme : faPrimaryTextTheme,
      // dividerColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: onBackground,
      ),
      colorScheme: ColorScheme(
              shadow: shadow,
              brightness: brightness,
              primary: primaryColor,
              onPrimary: onPrimary,
              secondary: secondaryColor,
              onSecondary: onSecondary,
              error: errorColor,
              onError: onError,
              background: backgroundColor,
              onBackground: onBackground,
              surface: surfaceColor,
              onSurface: onSurface)
          .copyWith(background: backgroundColor),
    );
  }
}


// class DarkTheme {
//   static const primaryColor = Color(0xffBB86FC);
//   static const primaryVariant = Color(0xff3700B3);
//   static const backgroundColor = Color(0xff121212);
//   static const surfaceColor = Color(0xff121212);
//   static const errorColor = Color(0xffCF6679);
//   static const onError = Colors.black;
//   static const secondaryColor = Color(0xff03DAC5);
//   // static const primaryTextColor = Color(0xff262A35);
//   static const secondaryTextColor = Color(0xffB3B6BE);
//   static const onPrimary = Colors.black;
//   static const onSecondary = Colors.black;
//   static const onBackground = Colors.white;
//   static const onSurface = Colors.white;
// }

// class LightTheme {
//   static const primaryColor = Color(0xff6200EE);
//   static const primaryVariant = Color(0xff3700B3);
//   static const backgroundColor = Color(0xffffffff);
//   static const surfaceColor = Color(0xffffffff);
//   static const errorColor = Color(0xffB00020);
//   static const onError = Colors.white;
//   static const secondaryColor = Color(0xff03DAC6);
//   // static const primaryTextColor = Color(0xff262A35);
//   static const secondaryTextColor = Color(0xffB3B6BE);
//   static const onPrimary = Colors.white;
//   static const onSecondary = Colors.black;
//   static const onBackground = Colors.black;
//   static const onSurface = Colors.black;
// }

