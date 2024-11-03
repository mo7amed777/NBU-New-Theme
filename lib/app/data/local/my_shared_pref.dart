import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/translations/localization_service.dart';

class MySharedPref {
  // get storage
  static late final _storage;

  // STORING KEYS
  static const String _userKey = 'user_data';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _grayScaleKey = 'is_gray_scale';
  static const String _majalesToken = 'majales_token';
  static const String _supportMeToken = 'majales_token';
  static const String _graduatedServicesToken = 'graduatedServices_token';
  static const String _auth = 'isAuthenticated';
  static const String _surveyCount = 'surveyCount';
  static const String _skillsRecordToken = 'skillsRecordToken';

  /// init get storage services
  static init() async {
    await GetStorage.init();
    _storage = GetStorage();
  }

  /// set current user data locally
  static void setUserData(Map<String, dynamic> userData) =>
      _storage.write(_userKey, userData);

  /// get current user data
  static Map<String, dynamic> getUserData() => _storage.read(_userKey);

  // /// set theme current type as light theme
  // static void setThemeIsLight(bool lightTheme) =>
  //     _storage.write(_lightThemeKey, lightTheme);

  // /// get if the current theme type is light
  // static bool getThemeIsLight() => _storage.read(_lightThemeKey) ?? true;

  /// set theme current type as light theme
  static void setIsGrayScale(bool grayScale) =>
      _storage.write(_grayScaleKey, grayScale);

  /// get if the current theme type is light
  static bool getIsGrayscale() => _storage.read(_grayScaleKey) ?? false;

  /// save current locale
  static void setCurrentLanguage(String languageCode) =>
      _storage.write(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _storage.read(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  /// Save Majales User Token
  static void setMajalesToken(String token) =>
      _storage.write(_majalesToken, token);

  /// get Majales User Token
  static String getMajalesToken() => _storage.read(_supportMeToken);

  /// Save Majales User Token
  static void setSupportMeToken(String token) =>
      _storage.write(_majalesToken, token);

  /// get Majales User Token
  static String getSupportMeToken() => _storage.read(_supportMeToken);

  /// Save Authenticated User Status
  static void setIsAuthenticated(bool authenticated) =>
      _storage.write(_auth, authenticated);

  /// get Authenticated User Status
  static bool getIsAuthenticated() => _storage.read(_auth) ?? false;

  /// Save GraduatedServices User Token
  static void setGraduatedServicesToken(String token) =>
      _storage.write(_graduatedServicesToken, token);

  /// get GraduatedServices User Token
  static String getGraduatedServicesToken() =>
      _storage.read(_graduatedServicesToken);

  /// Save Survey Count
  static void setSurveyCount(int count) => _storage.write(_surveyCount, count);

  /// get Survey Count
  static int getSurveyCount() => _storage.read(_surveyCount);

  /// Save Skills Record Token
  static void setSkillsRecordToken(String token) =>
      _storage.write(_skillsRecordToken, token);

  /// get Skills Record Token
  ///
  static String getSkillsRecordToken() => _storage.read(_skillsRecordToken);
}
