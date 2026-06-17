class CountryModel {
  final String name;
  final String capital;

  CountryModel({
    required this.name,
    required this.capital,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] ?? '',
      capital: json['capital'] ?? '',
    );
  }
}