class CityItem {
  final String? name;
  final String? countryCode;

  CityItem({
    this.name,
    this.countryCode
  });

  factory CityItem.fromJson({required Map<String, dynamic> json}) {
    return CityItem(
      name: json['name'],
      countryCode: json['country']
    );
  }
}