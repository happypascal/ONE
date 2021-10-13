import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings with ChangeNotifier {
  String _address = Const.DEFAULT_ADDRESS;

  String get address => this._address;

  Future<String?> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var address = prefs.getString('address');

    if (address != null) {
      print('debug saved address: $address');
      _address = address;
      notifyListeners();
      return null;
    }

    return 'no saved address';
  }

  Future saveAddress(String newAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('address', newAddress);
    _address = newAddress;
    notifyListeners();
  }
}
