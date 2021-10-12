import 'package:flutter/material.dart';

class Settings with ChangeNotifier {
  String? _address = '';

  String? get address => this._address;
}
