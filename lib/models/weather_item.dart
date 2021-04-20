class WeatherItem {
  final String? main;
  final String? description;

  WeatherItem({
    this.main,
    this.description
  });

  factory WeatherItem.fromJson({required List<Map<String, dynamic>> json}) {
    return WeatherItem(
      main: json.first['main'],
      description: json.first['description']
    );
  }
}