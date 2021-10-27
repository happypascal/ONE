import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheck {
  static Future<String?> checkWiFiConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.wifi) {
      print('debug Wi-Fi is not connected. Please connect ');
      return 'Wi-Fi is not connected. Please connect';
    } else {
      return null;
    }
  }
}
