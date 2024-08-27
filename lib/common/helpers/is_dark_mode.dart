import 'package:flutter/material.dart';

extension DarkMode on BuildContext { // Extend function of BuilContext
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
