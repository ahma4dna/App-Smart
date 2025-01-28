import 'package:flutter/material.dart';
import 'package:shoapsmart_useers_laerm/conest/app_colors.dart';

class Styles {
  static ThemeData themeData(
      {required bool isDarkTheam, required BuildContext context}) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: isDarkTheam ? Colors.white : Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: isDarkTheam
              ? AppColors.lightScaffoldColor
              : AppColors.darkScaffoldColor,
        ),
        backgroundColor: isDarkTheam
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
        centerTitle: false,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:isDarkTheam?Colors.white:Colors.black ,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          )
        )
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkTheam
            ? AppColors.darkScaffoldColor
            : AppColors.lightScaffoldColor,
      ),
      scaffoldBackgroundColor: isDarkTheam
          ? AppColors.darkScaffoldColor
          : AppColors.lightScaffoldColor,
      brightness: isDarkTheam ? Brightness.dark : Brightness.light,
      cardColor: isDarkTheam
          ? const Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.blue),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: isDarkTheam ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
