import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_element.dart';
import 'package:weather_app/repository/weather_repository.dart';

class WeatherBloc {
  static final _instance = WeatherBloc._();

  factory WeatherBloc() => _instance;

  WeatherBloc._();

  void deactivate() {
    weatherSC.close();
    streamSubscription.cancel();
  }

  WeatherRepository get _weatherRepository => WeatherRepository();

  StreamController<List<WeatherElement>> weatherSC = StreamController.broadcast();
  Stream<List<WeatherElement>> get weatherStream => weatherSC.stream;
  Sink<List<WeatherElement>> get weatherSink => weatherSC.sink;

  late StreamSubscription streamSubscription;

  List<WeatherElement> weatherElements = [];

  Future<void> getWeatherElements() async {
    Position? position = await getGeoPosition();
    if (position != null) {
      weatherElements = await _weatherRepository.fetchWeatherApi(position.latitude, position.longitude);
      weatherSink.add(weatherElements);
    } else {
      weatherSC.addError(NullThrownError);
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
}