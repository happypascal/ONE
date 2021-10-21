import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'dart:async';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'dart:typed_data';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';

class DeviceData with ChangeNotifier {
  ModbusClient? _client;
  Timer? _timer;
  Duration _timerPeriod = Duration(milliseconds: 1500);
  Duration _writeTimeout = Duration(milliseconds: 500);
  String _error = '';
  int _errorCount = 0;
  bool _isReading = false;

  bool _openCloseState = false;
  String _humMeasure = 'N/A';
  String _humSet = 'N/A';
  String _tempMeasure = 'N/A';
  String _tempSet = 'N/A';

  DeviceData(this._client);

  bool get openCloseState => this._openCloseState;
  ModbusClient? get client => this._client;
  String get error => this._error;
  String get humMeasure => this._humMeasure;
  String get humSet => this._humSet;
  String get tempMeasure => this._tempMeasure;
  String get tempSet => this._tempSet;

  Future<String?> readData(BuildContext context) async {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(_timerPeriod, (timer) {
      _periodicReading(context);
    });
  }

  _periodicReading(BuildContext context) async {
    if (_client == null) {
      print('debug Device is not connected');
      return;
    }
    print('debug start reading');
    _error = '';
    try {
      await _readRegisters();
    } catch (e) {
      _error = e.toString();
      if (!_error.contains('RangeError')) {
        _client = null;
        ScaffoldMessage.showErrorMessage(context, 'periodic read error: $e');
      }
      print('debug periodic read error: $e');
    }

    notifyListeners();
  }

  _readRegisters() async {
    try {
      _isReading = true;

      Uint16List registers = await _client!.readHoldingRegisters(0, 51);
      if (registers != null && registers.isNotEmpty) {
        print('debug registers list length: ${registers.length}');

        int openCloseState = registers[Const.OPEN_CLOSE_STATE];
        _openCloseState = openCloseState == 0 ? false : true;

        _humMeasure = registers[Const.HUM_MEASURE].toString();
        _humSet = registers[Const.HUM_SET].toString();
        _tempMeasure = registers[Const.TEMP_MEASURE].toString();
        _tempSet = registers[Const.TEMP_SET].toString();

        print('debug openCloseState: $openCloseState');
        print('debug _humMeasure: $_humMeasure');
        print('debug _humSet: $_humSet');
        print('debug _tempMeasure: $_tempMeasure');
        print('debug _tempSet: $_tempSet');
      }

      _isReading = false;
    } catch (e) {
      throw e.toString() + ' on _readRegisters';
    }
  }

  stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
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
}
