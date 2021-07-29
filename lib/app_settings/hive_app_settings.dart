import 'package:hive_flutter/adapters.dart';
import 'package:recipe_app/constants/constants_var_name.dart';

class HiveAppSettings {
  HiveAppSettings._();

  static bool _firsAppLaunch = true;
  static late Box _appPreferencesBox;

  static bool get getFirstLaunch => _firsAppLaunch;

  /// on user open app will define [getFirsAppLaunch] to [false]
  /// once set to [false], the application presentation will not be shown again.
  static onFirstLaunchConclusion() async {
    _firsAppLaunch = false;
    await _appPreferencesBox.put(FIRST_APP_LAUNCH, _firsAppLaunch);
  }

  static Future<void> initSingleton() async {
    await Hive.initFlutter();
    _appPreferencesBox = await Hive.openBox(APP_PREFERENCES_BOX_NAME);
    _setUpVariables();
  }

  static _setUpVariables() {
    _firsAppLaunch = _appPreferencesBox.get(FIRST_APP_LAUNCH) ?? true;
  }
}
