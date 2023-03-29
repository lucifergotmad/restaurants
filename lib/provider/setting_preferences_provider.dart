import 'package:flutter/cupertino.dart';
import 'package:restaurants/data/preferences/preferences_helper.dart';

class SettingPreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SettingPreferencesProvider({required this.preferencesHelper});

  bool _isDailyNotificationActive = false;

  bool get isDailyNotificationActive => _isDailyNotificationActive;

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive =
        await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void enableDailyNews(bool value) {
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPreferences();
  }
}
