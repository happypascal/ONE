import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'dart:async';

class DeviceData with ChangeNotifier {
  final ModbusClient? _client;
  Timer? _timer;

  DeviceData(this._client);

  Future<String?> readData() async {
    if (_timer != null || _timer!.isActive) {
      _timer!.cancel();
    }
  }

  Future<String?> writeData(int coilAddress, {bool data = true}) async {
    if (_client == null) {
      return 'Device is not connected';
    }
    try {
      var resp = await _client!.writeSingleCoil(coilAddress, data);

      if (resp is bool) {
        print('debug write resp: $resp');
        return null;
      } else {
        return 'Write command to $coilAddress failed';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
