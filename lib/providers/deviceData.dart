import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'dart:async';
import 'package:humidor_one_by_favre/utils/const.dart';

class DeviceData with ChangeNotifier {
  ModbusClient? _client;
  Timer? _timer;
  Duration _timerPeriod = Duration(milliseconds: 500);

  bool _openCloseState = false;

  DeviceData(this._client);

  bool get openCloseState => this._openCloseState;

  Future<String?> readData() async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(_timerPeriod, (timer) async {
      if (_client == null) {
        print('debug Device is not connected');
        return;
      }

      try {
        int openCloseState =
            (await _client!.readHoldingRegisters(Const.OPEN_CLOSE_STATE, 1))
                .first;
        if (openCloseState == 0) {
          _openCloseState = false;
        } else {
          _openCloseState = true;
        }
        print('debug openCloseState: $openCloseState');
      } catch (e) {
        _client = null;
        print('debug read OPEN_CLOSE_STATE error: $e');
      }

      notifyListeners();
    });
  }

  Future<String?> writeData(int coilAddress, {bool data = true}) async {
    if (_client == null) {
      return 'Device is not connected';
    }

    var res;
    try {
      var resp = await _client!.writeSingleCoil(coilAddress, data);

      if (resp is bool) {
        print('debug write resp: $resp');
      } else {
        res = 'Write command to $coilAddress failed';
      }
    } catch (e) {
      _client = null;
      print('debug error on write to coilAddress: $e');
      res = e.toString();
    }
    return res;
  }

  stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
