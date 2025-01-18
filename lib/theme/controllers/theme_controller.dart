import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/light_theme.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController with ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences!.setBool(AppConstants.theme, _darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences!.getBool(AppConstants.theme) ?? false;
    notifyListeners();
  }

  Color? selectedPrimaryColor;
  Color? selectedSecondaryColor;

  void setThemeColor({Color? primaryColor, Color? secondaryColor}) {
    selectedPrimaryColor = primaryColor;
    selectedPrimaryColor = secondaryColor;

    notifyListeners();
  }

  ThemeData theme = light();

  setColor(Color color) {
    theme = light(
      primaryColor: color,
    ).copyWith();
    notifyListeners();
  }

  reset() {
    theme = light();
    notifyListeners();
  }
}

setTheme(Color color) {
  Provider.of<ThemeController>(Get.context!, listen: false).setColor(color);
}

resetTheme() {
  Provider.of<ThemeController>(Get.context!, listen: false).reset();
}

getLang() {
  return Provider.of<LocalizationController>(Get.context!)
          .locale
          .languageCode ==
      "en";
}

bool get isLoggedIn {
  return Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();
}

ConfigModel getConfig() {
  return Provider.of<SplashController>(Get.context!, listen: false)
      .configModel!;
}

categoryById(int categoryId) {
  switch (categoryId) {
    case 1:
      return getLang() ? "Autos" : "سيارات";
    case 2:
      return getLang() ? "Real State" : "عقارات";
    case 3:
      return getLang() ? "Products" : "منتجات";
    case 4:
      return getLang() ? "Services" : "الخدمات";
    default:
      return getLang() ? "Default" : "أساسي";
  }
}
