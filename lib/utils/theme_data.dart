import 'package:flutter/material.dart';
import 'package:drinkit/utils/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    scaffoldBackgroundColor: Colors.white, 
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainColor,
      iconTheme: IconThemeData(color: AppColors.iconColor),
      titleTextStyle: TextStyle(
        color: AppColors.iconColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.mainColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColors.mainColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColors.listColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.listColor,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: AppColors.listColor,
        fontSize: 12,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.mainColor,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.iconColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    primaryColor: AppColors.mainColor,
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.mainColor,
      iconTheme: IconThemeData(color: AppColors.iconColor),
      titleTextStyle: TextStyle(
        color: AppColors.iconColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: AppColors.styleColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: AppColors.styleColor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: Colors.white, 
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.styleColor,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.iconColor,
    ),
    primaryTextTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white, 
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
