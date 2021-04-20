import 'main_item.dart';
import 'rain_item.dart';
import 'weather_item.dart';
import 'wind_item.dart';

class WeatherElement {
  final MainItem? mainItem;
  final WindItem? windItem;
  final RainItem? rainItem;
  final WeatherItem? weatherItem;
  final DateTime? dateTime;

  WeatherElement({
    this.mainItem,
    this.windItem,
    this.rainItem,
    this.weatherItem,
    this.dateTime
  });

  factory WeatherElement.fromJson({required Map<String, dynamic> json}) {
    return WeatherElement(
      mainItem: json['main'] != null ? MainItem.fromJson(json: json['main']) : null,
      windItem: json['wind'] != null ? WindItem.fromJson(json: json['wind']) : null,
      rainItem: json['rain'] != null ? RainItem.fromJson(json: json['rain']) : null,
      weatherItem: json['weather'] != null ? WeatherItem.fromJson(json: json['weather']) : null,
      dateTime: json['dt_txt'] != null ? DateTime.parse(json['dt_txt']) : null
    );
  }
}
