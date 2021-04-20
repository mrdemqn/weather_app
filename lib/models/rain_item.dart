class RainItem {
  final double? rainVolume;

  RainItem({
    this.rainVolume
  });

  factory RainItem.fromJson({required Map<String, dynamic> json}) {
    return RainItem(rainVolume: json['3h']);
  }
}