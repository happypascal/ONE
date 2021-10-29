import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'dart:async';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'dart:typed_data';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';
import 'package:humidor_one_by_favre/utils/connectivityCheck.dart';

class DeviceData with ChangeNotifier {
  ModbusClient? _client;
  Timer? _timer;
  Duration _timerPeriod = Duration(milliseconds: 1500);
  //Duration _writeTimeout = Duration(milliseconds: 500);
  String _error = '';
  int _errorCount = 0;
  bool _isWriting = false;

  bool _openCloseState = false;

  //TODO remove: for test and debug
  int _openCloseResp = 0;

  String _humMeasure = 'N/A';
  String _humSet = 'N/A';
  String _tempMeasure = 'N/A';
  String _tempSet = 'N/A';

  DeviceData(this._client);

  bool get openCloseState => this._openCloseState;

  //TODO remove: for test and debug
  int get openCloseResp => this._openCloseResp;

  ModbusClient? get client => this._client;
  String get error => this._error;
  String get humMeasure => this._humMeasure;
  String get humSet => this._humSet;
  String get tempMeasure => this._tempMeasure;
  String get tempSet => this._tempSet;
  bool get isWriting => this._isWriting;

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

    var connectivityResult = await ConnectivityCheck.checkWiFiConnection();
    if (connectivityResult != null) {
      _client = null;
      _error = connectivityResult;
      notifyListeners();
      return;
    }
    print('debug start reading');
    _error = '';

    ///we pass scheduled reading if writing is not done
    if (!_isWriting) {
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
    } else {
      _errorCount++;
      print('debug cancel reading because of writing');
      if (_errorCount > 2) {
        _errorCount = 0;
        _error = 'Writing error. Device is not reachable.';
        _client = null;
      }
    }

    notifyListeners();
  }

  _readRegisters() async {
    try {
      Uint16List registers = await _client!.readHoldingRegisters(0, 51);
      if (registers != null && registers.isNotEmpty) {
        print('debug registers list length: ${registers.length}');

        int openCloseState = registers[Const.OPEN_CLOSE_STATE];
        _openCloseResp = openCloseState;
        _openCloseState = openCloseState == 1 ? true : false;
        print('debug _openCloseState: $_openCloseState');

        _humMeasure = registers[Const.HUM_MEASURE].toString();
        _humSet = registers[Const.HUM_SET].toString();
        _tempMeasure = registers[Const.TEMP_MEASURE].toString();
        _tempSet = registers[Const.TEMP_SET].toString();

        _errorCount = 0;

        print('debug openCloseState: $openCloseState');
        print('debug _humMeasure: $_humMeasure');
        print('debug _humSet: $_humSet');
        print('debug _tempMeasure: $_tempMeasure');
        print('debug _tempSet: $_tempSet');
      }
    } catch (e) {
      throw e.toString() + ' on _readRegisters';
    }
  }

  stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  Future<String?> writeData(int coilAddress,
      {bool readWithOutWaiting = true}) async {
    if (_client == null) {
      return 'Device is not connected';
    }

    var res;
    try {
      ///to open or close set coil to true (button is pressed)
      _toggleIsWriting();
      var pressResp = await _client!.writeSingleCoil(coilAddress, true);

      if (pressResp is bool) {
        print('debug write pressResp: $pressResp');

        ///set coil to default state false (button is released)
        var releaseResp = await _client!.writeSingleCoil(coilAddress, false);

        if (releaseResp is bool) {
          print('debug write releaseResp: $releaseResp');

          ///if it is hum or temp updating need to read registers immdeately without cycle waiting
          if (readWithOutWaiting) {
            await _readRegisters();
            notifyListeners();
          }
        } else {
          res = 'Release button with coilAddress $coilAddress failed';
        }
      } else {
        res = 'Press button with coilAddress $coilAddress failed';
      }
    } catch (e) {
      if (!e.toString().contains('RangeError')) {
        res = e.toString() + '. Try to reconnect.';
      }
      print('debug error on write to coilAddress: $e');
    }
    _toggleIsWriting();
    return res;
  }

  _toggleIsWriting() {
    _isWriting = !_isWriting;
    notifyListeners();
  }
}
