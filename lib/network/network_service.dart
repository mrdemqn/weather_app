import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

class NetworkService {
  static final _instance = NetworkService._();

  factory NetworkService() => _instance;

  NetworkService._();

  Future<Map<String, dynamic>> getApi(Uri uri) async {
    return await get(uri)
    .then((response) => jsonDecode(response.body))
    .catchError((onError) {
      log('CatchError -> $onError');
    });
  }
}