import 'dart:async';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/errors/network_error.dart';
import 'package:weather_app/models/city_item.dart';
import 'package:weather_app/models/weather_element.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/utils/network_connection/internet_status_check.dart';
import 'package:weather_app/utils/share.dart';

class WeatherBloc {
  static final _instance = WeatherBloc._();

  factory WeatherBloc() => _instance;

  WeatherBloc._();

  void deactivate() {
    weatherSC.close();
    hasConnectionSub?.cancel();
    connectionStatus.deactivate();
  }

  WeatherRepository get _weatherRepository => WeatherRepository();
  ConnectionStatus get connectionStatus => ConnectionStatus();
  ShareText get shareText => ShareText();

  StreamController<List<WeatherElement>> weatherSC = StreamController.broadcast();
  Stream<List<WeatherElement>> get weatherStream => weatherSC.stream;
  Sink<List<WeatherElement>> get weatherSink => weatherSC.sink;

  StreamSubscription<ConnectivityResult>? hasConnectionSub;

  List<WeatherElement> weatherElements = [];
  late WeatherElement currentWeather;
  bool gettingWeather = false;

  CityItem? _currentCity;
  CityItem? get currentCity => _currentCity;
  set setCity(CityItem? v) => _currentCity = v;

  Future<void> getWeatherElements() async {
    await connectionStatus.checkConnection();
    hasConnectionSub = connectionStatus.connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (connectionStatus.hasConnection) {
      Position? position = await getGeoPosition();
      if (position != null) {
        weatherElements = await _weatherRepository.fetchWeatherApi(position.latitude, position.longitude)
        .catchError((onError) {
          weatherSC.addError(NullThrownError);
        });
        weatherSink.add(weatherElements);
        hasConnectionSub?.cancel();
      } else {
        weatherSC.addError(NullThrownError);
        await getWeatherElements();
      }
    } else if (weatherElements.isEmpty) {
      weatherSC.addError(NetworkError);
    }
  }

  Future<void> getCurrentWeather() async {
    await connectionStatus.checkConnection();
    hasConnectionSub = connectionStatus.connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (connectionStatus.hasConnection) {
      Position? position = await getGeoPosition();
      if (position != null) {
        currentWeather = await _weatherRepository.fetchCurrentWeatherApi(position.latitude, position.longitude)
        .catchError((onError) {
          weatherSC.addError(NullThrownError);
        });
        weatherSink.add(weatherElements);
        hasConnectionSub?.cancel();
      } else {
        weatherSC.addError(NullThrownError);
        await getWeatherElements();
      }
    } else if (weatherElements.isEmpty) {
      weatherSC.addError(NetworkError);
    }
  }

  Future<Position?> getGeoPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
    .then((position) => position)
    .catchError((onError) {
      log('Get Position Error -> $onError');
      weatherSC.addError(NullThrownError);
    });
  }

  Future<void> _updateConnectionStatus(ConnectivityResult? result) async {
    bool? hasConnection = await connectionStatus.checkConnection();
    if (hasConnection != null && hasConnection && !gettingWeather) {
      gettingWeather = true;
      await getWeatherElements();
      gettingWeather = false;
    }
  }

  Future<void> shareWeatherText(String text) async {
    await shareText.shareWeather(text);
  }

  String getWindDirection(num value) {
    String direction = 'SE';
    if (value >= 10 && value <= 80)
      direction = 'NE';
    else if (value > 80 && value < 100)
      direction = 'E';
    else if (value >= 100 && value <= 170)
      direction = 'SE';
    else if (value > 170 && value < 190)
      direction = 'S';
    else if (value >= 190 && value <= 260)
      direction = 'SW';
    else if (value > 260 && value < 280)
      direction = 'W';
    else if (value >= 280 && value <= 350)
      direction = 'NW';
    else if (value > 350 && value < 10)
      direction = 'N';
    return direction;
  }
}

extension IntExt on int {
  String twoDigitsMin(int? n) => n.toString().padLeft(2, '0');
  String? get twoDigits => twoDigitsMin(this.remainder(60));
}

extension StringExt on String {
  String capitalize() => '${this[0].toUpperCase()}${this.substring(1)}';
}