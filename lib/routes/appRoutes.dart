import 'package:humidor_one_by_favre/screens/homescreen/homeScreen.dart';
import 'package:humidor_one_by_favre/screens/settings/settingsScreen.dart';

class AppRoutes {
  static const HOME_SCREEN = 'homescreen';
  static const SETTINGS_SCREEN = 'settings';

  static initialRoute(String screen) {
    return screen;
  }

  static getRoutes() {
    return {
      HOME_SCREEN: (ctx) => HomeScreen(),
      SETTINGS_SCREEN: (ctx) => SettingsScreen(),
    };
  }
}
