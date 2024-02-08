import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/images.dart';

class LanguageController extends GetxController {
  final SharedPreferences sharedPreferences;
  LanguageController({required this.sharedPreferences});

  int _selectIndex = 0;
  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    update();
  }

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
      update();
    } else {
      _selectIndex = -1;
      _languages = [];
      for (var product in AppConstants.languages) {
        if (product.languageName!.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      }
      update();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
    }
  }
}

class LanguageModel {
  String? imageUrl;
  String? languageName;
  String? languageCode;
  String? countryCode;

  LanguageModel(
      {this.imageUrl, this.languageName, this.countryCode, this.languageCode});
}
// ignore_for_file: constant_identifier_names

class AppConstants {
  static String fontFamily = 'Cairo';
  // static String fontFamily = 'https://marsalogistics.com/new/resting/api/show_request_permission_api.php';

  static String baseUrl = 'https://marsalogistics.com/new/resting/api';
  static const String login = '/login1.php';
  static const String requestPermission = '/show_request_permission_api.php';

  static const String appName = 'Marsa HR';
  static const bool demo = true;

  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String REQHEADER = 'REQ-HEADER';
  static const String USERDATA = 'USER-DATA';
  static const String CAMPANYDATA = 'CAMPANY-DATA';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String CUSTOMER_CART_LIST = 'customer_cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_EMAIL = 'USER_EMAIL';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String ZONE_TOPIC = 'zone_topic';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  // static const requestHeader = 'request_header';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: Images.united_kingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
