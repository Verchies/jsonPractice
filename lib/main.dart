import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:requestpractice/model.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // api https://api.nationalize.io/?name=michael

  Future<CountryCevap> tumCountry() async {
    final response =
        await http.get(Uri.parse('https://api.nationalize.io/?name=michael'));

    return CountryCevap.fromjson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: FutureBuilder(
                future: tumCountry(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(snapshot.data.name);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              centerTitle: true,
            ),
            body: FutureBuilder<CountryCevap>(
              future: tumCountry(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data!.countryList.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data!.countryList[index].country_id),
                          subtitle: Text(snapshot
                              .data!.countryList[index].probability
                              .toString()),
                        );
                      }));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }
}

/*
Center(
                    child: Text('${snapshot.data[1].probability}'),
                  );

                  FutureBuilder(
              future: tumCountry(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    title: Text(snapshot.data[0].country_id),
                    subtitle: Text(dene.name),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
 */