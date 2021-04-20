import 'dart:async'; //For StreamController/Stream
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

  StreamSubscription? networkStatus;

  Stream<bool> get connectionChange => connectionChangeSC.stream;

  void deactivate() {
    connectionChangeSC.close();
    networkStatus?.cancel();
  }

  void listenConnection() {
    networkStatus = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
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

  Future<void> _updateConnectionStatus(ConnectivityResult? result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        checkConnection();
        break;
      case ConnectivityResult.mobile:
        checkConnection();
        break;
      case ConnectivityResult.none:
        checkConnection();
        break;
      default:
        checkConnection();
        break;
    }
  }
}