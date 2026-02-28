import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<bool> isOnboardingSeen();
  Future<void> setOnboardingSeen();
  Future<void> saveLocaleCode(String localeCode);
  Future<String?> getLocaleCode();

  // Form
  Future<void> saveFormAnswers(Map<String, String> answers);
  Future<Map<String, String>> getFormAnswers();
  Future<void> saveFormCurrentPage(int page);
  Future<int> getFormCurrentPage();
  Future<bool> isUserFormCompleted();
  Future<void> setUserFormCompleted();
  Future<void> clearFormData();
}

class LocalStorageServiceImpl implements LocalStorageService {
  static const _tokenKey = 'token';
  static const _onboardingKey = 'is_onboarding_seen';
  static const _localeCodeKey = 'locale_code';
  static const _formAnswersKey = 'form_answers';
  static const _formCurrentPageKey = 'form_current_page';
  static const _formCompletedKey = 'is_form_completed';

  @override
  Future<void> saveToken(String token) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(_tokenKey);
  }

  @override
  Future<bool> isOnboardingSeen() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> setOnboardingSeen() async {
    final storage = await SharedPreferences.getInstance();
    storage.setBool(_onboardingKey, true);
  }

  @override
  Future<void> saveLocaleCode(String localeCode) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(_localeCodeKey, localeCode);
  }

  @override
  Future<String?> getLocaleCode() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(_localeCodeKey);
  }

  @override
  Future<void> saveFormAnswers(Map<String, String> answers) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(_formAnswersKey, jsonEncode(answers));
  }

  @override
  Future<Map<String, String>> getFormAnswers() async {
    final storage = await SharedPreferences.getInstance();
    final raw = storage.getString(_formAnswersKey);
    if (raw == null) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((k, v) => MapEntry(k, v.toString()));
  }

  @override
  Future<void> saveFormCurrentPage(int page) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setInt(_formCurrentPageKey, page);
  }

  @override
  Future<int> getFormCurrentPage() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getInt(_formCurrentPageKey) ?? 0;
  }

  @override
  Future<bool> isUserFormCompleted() async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(_formCompletedKey) ?? false;
  }

  @override
  Future<void> setUserFormCompleted() async {
    final storage = await SharedPreferences.getInstance();
    await storage.setBool(_formCompletedKey, true);
  }

  @override
  Future<void> clearFormData() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove(_formAnswersKey);
    await storage.remove(_formCurrentPageKey);
  }
}
