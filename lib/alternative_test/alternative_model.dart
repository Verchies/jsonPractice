class Country2 {
  String country_id;
  double probability;

  Country2({
    required this.country_id,
    required this.probability,
  });

  factory Country2.fromJson(Map<String, dynamic> json) => Country2(
        country_id: json["country_id"] as String,
        probability: json["probability"] as double,
      );
}

class countryCevap2 {
  List<Country2> country;
  String name;

  countryCevap2({
    required this.name,
    required this.country,
  });

  factory countryCevap2.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["country"] as List;

    List<Country2> country =
        jsonArray.map((i) => Country2.fromJson(i)).toList();

    return countryCevap2(name: json['name'] as String, country: country);
  }
}
