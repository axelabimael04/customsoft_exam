import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData define() {
    final Color primary = Color(0xFF004afd);
    final Color primaryContainer = Color(0xFF303443);
    final Color onPrimary = Color(0xDDFFFFFF);

    final Color secondary = Color(0xFF0D873F);
    final Color secondaryContainer = Color(0xFF0D873F);
    final Color onSecondary = Color(0xDDFFFFFF);

    final Color background = Color(0xFFFFFFFF);
    final Color onBackground = Color(0xFF000000);

    final Color error = Color(0xFF941914);
    final Color onError = Color(0xFFFFFF);

    return ThemeData(
      colorScheme: ColorScheme(
        primary: primary,
        primaryContainer: primaryContainer,
        onPrimary: onPrimary,
        secondary: secondary,
        secondaryContainer: secondaryContainer,
        onSecondary: onSecondary,
        surface: background,
        onSurface: onBackground,
        error: error,
        onError: onError,
        brightness: Brightness.light,
      ),
      useMaterial3: false,
      primaryColorDark: secondaryContainer,
      scaffoldBackgroundColor: background,
      dividerColor: onBackground,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.oxygen(color: onBackground),
          iconColor: onBackground,
        ),
      ),
      iconTheme: IconThemeData(color: onBackground, size: 20),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textStyle: GoogleFonts.oxygen(
            fontSize: 14,
            color: onBackground,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: onBackground,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: background,
          foregroundColor: onBackground,
          elevation: 0,
          centerTitle: false),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 0.1, color: Colors.grey[600]!),
        ),
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 11,
        backgroundColor: onBackground,
        unselectedIconTheme: IconThemeData(size: 20),
        selectedIconTheme: IconThemeData(size: 25),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[600],
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(
        selectedColor: background,
        fillColor: onBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      textTheme: TextTheme(
        //Display
        displayLarge: GoogleFonts.oxygen(
            fontSize: 32, color: onBackground, fontWeight: FontWeight.w700),
        displayMedium: GoogleFonts.oxygen(fontSize: 30, color: onBackground),
        displaySmall: GoogleFonts.oxygen(fontSize: 28, color: onBackground),

        //Headline
        headlineLarge: GoogleFonts.oxygen(
            fontSize: 28, color: onBackground, fontWeight: FontWeight.w700),
        headlineMedium: GoogleFonts.oxygen(fontSize: 26, color: onBackground),
        headlineSmall: GoogleFonts.oxygen(fontSize: 24, color: onBackground),

        //Title
        titleLarge: GoogleFonts.oxygen(
            fontSize: 24, color: onBackground, fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.oxygen(fontSize: 22, color: onBackground),
        titleSmall: GoogleFonts.oxygen(fontSize: 20, color: onBackground),

        //Label
        labelLarge: GoogleFonts.oxygen(
            fontSize: 20, color: onBackground, fontWeight: FontWeight.w700),
        labelMedium: GoogleFonts.oxygen(fontSize: 18, color: onBackground),
        labelSmall: GoogleFonts.oxygen(fontSize: 16, color: onBackground),

        //body
        bodyLarge: GoogleFonts.oxygen(
            fontSize: 16, color: onBackground, fontWeight: FontWeight.w700),
        bodyMedium: GoogleFonts.oxygen(fontSize: 14, color: onBackground),
        bodySmall: GoogleFonts.oxygen(fontSize: 12, color: onBackground),
      ),
    );
  }
}
