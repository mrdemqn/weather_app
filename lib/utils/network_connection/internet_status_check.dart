import 'dart:async'; //For StreamController/Stream
import 'dart:developer';
import 'dart:io'; //InternetAddress utility

import 'package:connectivity/connectivity.dart';

class ConnectionStatus {
  static final _instance = ConnectionStatus._();

  factory ConnectionStatus() => _instance;

  ConnectionStatus._();

  bool _hasConnection = false;
  bool get hasConnection => _hasConnection;

  StreamController<bool> connectionChangeSC = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();
  Connectivity get connectivity => _connectivity;

  Stream<bool> get connectionChange => connectionChangeSC.stream;

  void deactivate() {
    connectionChangeSC.close();
  }

  Future<bool?> checkConnection() async {
    bool previousConnection = _hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } on SocketException catch(_) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection) {
      connectionChangeSC.add(_hasConnection);
    }
    return _hasConnection;
  }
}