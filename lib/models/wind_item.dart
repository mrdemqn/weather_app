class WindItem {
  final double? windSpeed;
  final int? windDirection;

  WindItem({
    this.windSpeed,
    this.windDirection,
  });

  factory WindItem.fromJson({required Map<String, dynamic> json}) {
    return WindItem(
      windSpeed: json['speed'],
      windDirection: json['deg']
    );
  }
}