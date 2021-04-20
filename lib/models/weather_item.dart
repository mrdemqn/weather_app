class WeatherItem {
  final String? main;
  final String? description;
  final String? icon;

  WeatherItem({
    this.main,
    this.description,
    this.icon
  });

  factory WeatherItem.fromJson({required List<dynamic> json}) {
    return WeatherItem(
      main: json.first['main'],
      description: json.first['description'],
      icon: 'https://openweathermap.org/img/wn/${json.first['icon']}.png'
    );
  }
}