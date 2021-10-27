import 'package:flutter/material.dart';
import 'package:modbus/modbus.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:humidor_one_by_favre/utils/connectivityCheck.dart';

class Connect with ChangeNotifier {
  String _address = Const.DEFAULT_ADDRESS;
  ModbusClient? _client;
  int _port = 5022; //TODO change it to 502 for release version
  bool _isConnecting = false;
  bool _isConnected = false;

  Connect(this._address);

  String get address => this._address;
  ModbusClient? get client => this._client;
  bool get isConnecting => this._isConnecting;
  bool get isConnected => this._isConnected;

  Future<String?> connect() async {
    var connectivityResult = await ConnectivityCheck.checkWiFiConnection();
    if (connectivityResult != null) {
      _client = null;
      notifyListeners();
      return connectivityResult;
    }

    print('debug start connect');
    _client = createTcpClient(
      _address,
      port: _port,
      mode: ModbusMode.rtu,
    );

    var res;

    try {
      bool timeOutError = false;
      await _client!.connect().timeout(Duration(seconds: 10), onTimeout: () {
        timeOutError = true;
        print('debug timeOutError:$timeOutError');
        _client!.close();
      });
      if (!timeOutError) {
        _isConnected = true;
        notifyListeners();
        return res;
      } else {
        return 'Connection timeout error, please check address in the settings and try again';
      }
    } catch (e) {
      print('debug connect error: $e ');
      throw (e);
    }
  }

  disconnect() {
    _client!.close();
    _client = null;
    _isConnected = false;
  }
}
