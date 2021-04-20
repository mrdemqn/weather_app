import 'package:share/share.dart';

class ShareText {
  static final _instance = ShareText._();

  factory ShareText() => _instance;

  ShareText._();

  Future<void> shareWeather(String text) async {
    await Share.share(text);
  }
}