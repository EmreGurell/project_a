import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<bool> isOnboardingSeen();
  Future<void> setOnboardingSeen();
  Future<void> saveLocaleCode(String localeCode);
  Future<String?> getLocaleCode();
}

class LocalStorageServiceImpl implements LocalStorageService {
  static const _tokenKey = 'token';
  static const _onboardingKey = 'is_onboarding_seen';
  static const _localeCodeKey = 'locale_code';

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
}
