import 'dart:convert';

import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/screes/auth/auth_screen.dart';
import 'package:betakety_app/controllers/banner_controller.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/view/screes/home/nav_screen.dart';
import 'package:betakety_app/view/screes/home/widget/squer_screen.dart';
import 'package:betakety_app/view/screes/home/widget/custom_drawer.dart';
import 'package:betakety_app/view/screes/home/widget/widget_list.dart';
import 'package:betakety_app/view/screes/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/language_controller.dart';
import 'controllers/localization_controller.dart';
import 'view/screes/home/home_screen.dart';
import 'view/screes/profile/profile_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('is_logged_in');
  Map<String, Map<String, String>> languages = await init();
  runApp(MyApp(languages: languages, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final bool? isLoggedIn;

  const MyApp({Key? key, required this.languages, this.isLoggedIn})
      : super(key: key);

  get d => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizeController) {
        return GetMaterialApp(
          theme: ThemeData(
            // useMaterial3: true,
            fontFamily: AppConstants.fontFamily,
            primaryColor: kMainColor,
            secondaryHeaderColor: const Color(0xFF1ED7AA),
            disabledColor: const Color(0xFFBABFC4),
            brightness: Brightness.light,
            hintColor: const Color(0xFF9F9F9F),
            cardColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: kMainColor)),
            colorScheme: const ColorScheme.light(
                    primary: kMainColor, secondary: kMainColor)
                .copyWith(background: const Color(0xFFF3F3F3))
                .copyWith(error: const Color(0xFFE84D4F)),
          ),
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
              AppConstants.languages[0].countryCode),
          home: const Splash(),

          // home: isLoggedIn == true ? Myapp() : AuthScreen(),

          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}

//mmmmmmmmmmmmmm

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);

  // Repository

  Get.put(LanguageRepo());

  // Controller

  Get.put(LocalizationController(sharedPreferences: Get.find()));
  Get.put(LanguageController(sharedPreferences: Get.find()));

  Get.put(NavbarController());
  Get.put(BannersController());
  Get.put(AuthController());
  Get.put(PermissionController());
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsons = {};
    mappedJson.forEach((key, value) {
      jsons[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        jsons;
  }

  return languages;
}

class Messages extends Translations {
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
