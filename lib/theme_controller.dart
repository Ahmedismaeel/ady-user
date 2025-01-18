// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sixvalley_ecommerce/main.dart';
// import 'package:flutter_sixvalley_ecommerce/main_helper.dart';
// import 'package:flutter_sixvalley_ecommerce/theme/light_theme.dart';

// class ThemeNotifier extends StateNotifier<ThemeData> {
//   ThemeNotifier() : super(light());
//   setColor(Color color) {
//     state = light(primaryColor: color, secondaryColor: color.withOpacity(0.3))
//         .copyWith(
//             scaffoldBackgroundColor: color.withOpacity(0.3),
//             bottomNavigationBarTheme:
//                 BottomNavigationBarThemeData(backgroundColor: color));
//   }

//   reset() {
//     state = light();
//   }
// }

// final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
//   return ThemeNotifier();
// });

// getTheme() {
//   return homeRef.watch(themeProvider);
// }
