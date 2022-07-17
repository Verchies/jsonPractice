import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requestpractice/alternative_test/alternative_model.dart';

void main() => runApp(const MyApp2());

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  Future<List<countryCevap2>> listeFuture = apiCall();

  static Future<List<countryCevap2>> apiCall() async {
    const url =
        'https://api.nationalize.io/?name[]=michael&name[]=matthew&name[]=jane';

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body
        .map<countryCevap2>((json) => countryCevap2.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(title: const Text('API'), centerTitle: true),
          body: FutureBuilder<List<countryCevap2>>(
              future: listeFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final country = snapshot.data!;
                  return buildUsers(country);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  Widget buildUsers(List<countryCevap2> country) => ListView.builder(
      itemCount: country.length,
      itemBuilder: ((context, index) {
        final countryF = country[index];
        return ListTile(
          title: Text(countryF.name),
          subtitle: Text(
              '${countryF.country[index].country_id} - ${countryF.country[index].probability}'),
        );
      }));
}
