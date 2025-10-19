// // flutter_app_theme.dart
// // A ready-to-use Flutter Theme file using primary color #6B48FF
// // - Material 3 (ColorScheme.fromSeed)
// // - Light and dark themes
// // - Button, AppBar, InputDecoration, FAB, and other component theming

// import 'package:flutter/material.dart';

// class AppTheme {
//   // Primary color requested by the user
//   static const Color _primary = Color(0xFF6B48FF);

//   // Optional accent / complementary colors (tuned to the primary)
//   static const Color _primaryContainer = Color(0xFFECE6FF);
//   static const Color _onPrimary = Colors.white;

//   // Disabled / inactive color — choose something slightly muted
//   static const Color _disabled = Color(0xFFBFB6E6);

//   // Light theme
//   static ThemeData light() {
//     final ColorScheme colorScheme = ColorScheme.fromSeed(
//       seedColor: _primary,
//       brightness: Brightness.light,
//     );

//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: colorScheme,
//       primaryColor: _primary,
//       scaffoldBackgroundColor: colorScheme.background,
//       appBarTheme: AppBarTheme(
//         backgroundColor: colorScheme.primary,
//         foregroundColor: colorScheme.onPrimary,
//         elevation: 0,
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           color: colorScheme.onPrimary,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: colorScheme.primary,
//         foregroundColor: colorScheme.onPrimary,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: TextStyle(fontWeight: FontWeight.w600),
//           disabledBackgroundColor: _disabled,
//           disabledForegroundColor: Colors.white.withOpacity(0.6),
//         ),
//       ),
//       filledButtonTheme: FilledButtonThemeData(
//         style: FilledButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
//       ),
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           foregroundColor: colorScheme.primary,
//           side: BorderSide(color: colorScheme.primary.withOpacity(0.16)),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: colorScheme.surfaceVariant,
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
//       ),
//       cardTheme: CardThemeData(
//         color: colorScheme.surface,
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       checkboxTheme: CheckboxThemeData(
//         fillColor: MaterialStateProperty.resolveWith((states) {
//           if (states.contains(MaterialState.disabled)) return _disabled;
//           return colorScheme.primary;
//         }),
//       ),
//       switchTheme: SwitchThemeData(
//         trackColor: MaterialStateProperty.resolveWith(
//           (states) => colorScheme.primary.withOpacity(0.4),
//         ),
//         thumbColor: MaterialStateProperty.resolveWith(
//           (states) => colorScheme.primary,
//         ),
//       ),
//       dialogTheme: DialogThemeData(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       ),
//       snackBarTheme: SnackBarThemeData(
//         backgroundColor: colorScheme.primary,
//         contentTextStyle: TextStyle(color: colorScheme.onPrimary),
//       ),
//       // Text theme — you can replace with GoogleFonts or your own TextTheme
//       textTheme: Typography.material2021().black.apply(
//         bodyColor: colorScheme.onBackground,
//       ),
//     );
//   }

//   // Dark theme
//   static ThemeData dark() {
//     final ColorScheme colorScheme = ColorScheme.fromSeed(
//       seedColor: _primary,
//       brightness: Brightness.dark,
//     );

//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: colorScheme.background,
//       appBarTheme: AppBarTheme(
//         backgroundColor: colorScheme.surface,
//         foregroundColor: colorScheme.onSurface,
//         elevation: 0,
//         centerTitle: true,
//       ),
//       floatingActionButtonTheme: FloatingActionButtonThemeData(
//         backgroundColor: colorScheme.primary,
//         foregroundColor: colorScheme.onPrimary,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           textStyle: TextStyle(fontWeight: FontWeight.w600),
//           disabledBackgroundColor: _disabled,
//           disabledForegroundColor: Colors.white.withOpacity(0.6),
//         ),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: colorScheme.surfaceVariant,
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
//       ),
//       textTheme: Typography.material2021().white.apply(
//         bodyColor: colorScheme.onBackground,
//       ),
//     );
//   }
// }