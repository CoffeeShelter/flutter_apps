import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(
    // Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    Uri.parse('http://211.59.155.146:5000/detection'),
    // Uri.parse('http://127.0.0.1:5000/detection'),
  );

  if(response.statusCode == 200 || response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-type' : 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  }else {
    throw Exception('Failed to delete album');
  }
}

class Album {
  final int? id;
  final String? title;

  Album({
    this.id,
    this.title
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Delete Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: _futureAlbum, 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(snapshot.data?.title ?? 'Deleted'),
                      ElevatedButton(
                        child: const Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            _futureAlbum =
                                deleteAlbum(snapshot.data!.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if(snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}