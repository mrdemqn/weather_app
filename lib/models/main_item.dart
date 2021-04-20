class MainItem {
  final num? temperature;
  final int? groundLevel;
  final int? humidity;

  MainItem({
    this.temperature,
    this.groundLevel,
    this.humidity,
  });

  factory MainItem.fromJson({required Map<String, dynamic> json}) {
    return MainItem(
      temperature: json['temp'],
      groundLevel: json['grnd_level'],
      humidity: json['humidity']
    );
  }
}