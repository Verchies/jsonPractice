class Country {
  String country_id;
  double probability;

  Country({
    required this.country_id,
    required this.probability,
  });

  factory Country.fromjson(Map<String, dynamic> json) {
    return Country(
      country_id: json['country_id'] as String,
      probability: json['probability'] as double,
    );
  }
}

class CountryCevap {
  String name;
  List<Country> countryList;

  CountryCevap({
    required this.name,
    required this.countryList,
  });

  factory CountryCevap.fromjson(Map<String, dynamic> json) {
    var jsonArray = json['country'] as List;
    List<Country> countryList = jsonArray
        .map((jsonArrayNesnesi) => Country.fromjson(jsonArrayNesnesi))
        .toList();
    return CountryCevap(
      name: json['name'] as String,
      countryList: countryList,
    );
  }
}

/*
List<Country> myModels;
var response = await http.get("myUrl");

myModels=(json.decode(response.body) as List).map((i) =>
              MyModel.fromJson(i)).toList();
 */