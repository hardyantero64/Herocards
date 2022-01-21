import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Number> fetchNumber() async {
  final response = await http.get(Uri.parse('http://localhost/index.php'));
  //headers: { 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Headers': '*'});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Number.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load hotel');
  }
}

class Number {
  final String name;

  Number({
    required this.name,
  });

  factory Number.fromJson(Map<String, dynamic> json) {
    return Number(
      name: json['number'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Number> futureNumber;

  @override
  void initState() {
    super.initState();
    futureNumber = fetchNumber();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/Profile.jpg'),
              ),
              Text(
                'Captain America',
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'Bebas Neue',
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.red.shade700,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FutureBuilder<Number>(
                        future: futureNumber,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade900,
                                fontFamily: ('Barlow Condensed'),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.red.shade700,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FutureBuilder<Number>(
                        future: futureNumber,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade900,
                                fontFamily: ('Barlow Condensed'),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
