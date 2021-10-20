import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'dart:async';
import 'package:humidor_one_by_favre/utils/const.dart';

class DeviceData with ChangeNotifier {
  ModbusClient? _client;
  Timer? _timer;
  Duration _timerPeriod = Duration(milliseconds: 500);
  Duration _writeTimeout = Duration(milliseconds: 500);

  bool _openCloseState = false;
  String _error = '';

  DeviceData(this._client);

  bool get openCloseState => this._openCloseState;
  ModbusClient? get client => this._client;
  String get error => this._error;

  Future<String?> readData() async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(_timerPeriod, (timer) async {
      if (_client == null) {
        print('debug Device is not connected');
        return;
      }

      _error = '';

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
        _error = e.toString();
        print('debug read OPEN_CLOSE_STATE error: $e');
      }

      notifyListeners();
    });
  }

  Future<String?> writeData(int coilAddress) async {
    if (_client == null) {
      return 'Device is not connected';
    }

    var res;
    try {
      ///to open or close set coil to true (button is pressed)
      var pressResp = await _client!.writeSingleCoil(coilAddress, true);

      if (pressResp is bool) {
        print('debug write pressResp: $pressResp');

        ///set coil to default state false (button is released)
        var releaseResp = await _client!.writeSingleCoil(coilAddress, false);

        if (releaseResp is bool) {
          print('debug write releaseResp: $releaseResp');
        } else {
          res = 'Release button with coilAddress $coilAddress failed';
        }
      } else {
        res = 'Press button with coilAddress $coilAddress failed';
      }
    } catch (e) {
      print('debug error on write to coilAddress: $e');
      res = e.toString() + '. Try to reconnect.';
    }
    return res;
  }

  stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }
}
