import 'package:shared_preferences/shared_preferences.dart';

class OnceCacheService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setOnBoardingCache() async {
    await _prefs.setString('onboarding_completed', 'completed');
  }

  Future<String?> getOnBoardingCache() async {
    final data = _prefs.getString('onboarding_completed');
    return data;
  }
}
