import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/utils/const.dart';

class Settings with ChangeNotifier {
  String _address = Const.DEFAULT_ADDRES;

  String get address => this._address;
}
