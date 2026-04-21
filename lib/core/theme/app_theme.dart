import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors: Tonal Depth & Gold Accents
  static const Color primaryGold = Color(0xFF775A19);
  static const Color primaryGoldContainer = Color(0xFFC5A059);
  static const Color surfaceParchment = Color(0xFFFAF9F8);
  static const Color surfaceContainerLow = Color(0xFFF4F3F2);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurfaceSoftBlack = Color(0xFF1A1C1C);
  static const Color secondaryMetadata = Color(0xFF5F5E5E);
  static const Color ghostBorder = Color(0xFFD1C5B4);
  static const Color tertiaryError = Color(0xFFA43A37);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGold,
        primary: primaryGold,
        primaryContainer: primaryGoldContainer,
        surface: surfaceParchment,
        onSurface: onSurfaceSoftBlack,
        error: tertiaryError,
      ),
      scaffoldBackgroundColor: surfaceParchment,
      
      // Typography: The Academic Voice
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.02 * 56,
          color: onSurfaceSoftBlack,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.bold,
          color: onSurfaceSoftBlack,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          color: secondaryMetadata,
          letterSpacing: 0.5,
        ),
      ).apply(
        bodyColor: onSurfaceSoftBlack,
        displayColor: onSurfaceSoftBlack,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: onSurfaceSoftBlack),
        titleTextStyle: TextStyle(
          color: onSurfaceSoftBlack,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: primaryGold,
          foregroundColor: Colors.white,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ghostBorder.withAlpha(51)), // 20% opacity
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ghostBorder.withAlpha(51)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryGold, width: 1),
        ),
        labelStyle: const TextStyle(color: secondaryMetadata),
      ),
    );
  }

  // Signature Texture: Gradient for primary actions
  static Gradient get goldGradient => const LinearGradient(
        colors: [primaryGold, primaryGoldContainer],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // Ambient Shadows: Blur 32-64px, Opacity 4-6%
  static List<BoxShadow> get ambientShadow => [
        BoxShadow(
          color: onSurfaceSoftBlack.withAlpha(15), // ~6% opacity
          blurRadius: 48,
          offset: const Offset(0, 8),
        ),
      ];

  static Color gradeColor(String? grade) => switch (grade?.trim()) {
        'ممتاز' => const Color(0xFF2E7D32),
        'جيد جدا' => const Color(0xFF388E3C),
        'جيد' => const Color(0xFF1565C0),
        'مقبول' => const Color(0xFFE65100),
        'راسب' => const Color(0xFFC62828),
        _ => const Color(0xFF757575),
      };
}
