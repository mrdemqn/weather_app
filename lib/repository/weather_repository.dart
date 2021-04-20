import 'package:weather_app/models/weather_element.dart';
import 'package:weather_app/constants/api_constants.dart';
import 'package:weather_app/network/network_service.dart';

class WeatherRepository {
  static final _instance = WeatherRepository._();

  factory WeatherRepository() => _instance;

  WeatherRepository._();

  NetworkService get _networkService => NetworkService();

  Future<List<WeatherElement>> fetchWeatherApi(double? lat, double? lon) async {
    final uri = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apiKey');
    Map<String, dynamic> response = await _networkService.getApi(uri);
    List<dynamic> list = response['list'];
    List<WeatherElement> weatherElements = list.map((json) => WeatherElement.fromJson(json: json)).toList();
    return Future.value(weatherElements);
  }
}