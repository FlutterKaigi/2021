import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static ThemeData get theme {
    // Typography
    final originTypography =
        (Typography.material2018(platform: defaultTargetPlatform).black).merge(
            Typography.material2018(platform: defaultTargetPlatform).dense);

    final textTheme = originTypography.copyWith(
      // Button
      button: originTypography.button?.merge(const TextStyle(
          fontFamily: 'Montserrat-Bold', fontWeight: FontWeight.bold)),
    );

    return ThemeData(
      fontFamily: 'Montserrat',
      textTheme: textTheme,
      primarySwatch: Colors.blue,
      backgroundColor: Colors.white,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.black, // text
          // enabledMouseCursor: MouseCursor.defer,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white, // foreground(text)
          // enabledMouseCursor: MouseCursor.defer,
        ),
      ),
    );
  }
}
