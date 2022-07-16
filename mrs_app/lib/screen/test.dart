import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// void main() => runApp(MyApp());

// To parse this JSON data, do
//
//     final designations = designationsFromJson(jsonString);

List<Designations> designationsFromJson(String str) => List<Designations>.from(
    json.decode(str).map((x) => Designations.fromJson(x)));

String designationsToJson(List<Designations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Designations {
  String designationId;
  String designation;

  Designations({
    required this.designationId,
    required this.designation,
  });

  factory Designations.fromJson(Map<String, dynamic> json) => Designations(
        designationId: json["DesignationId"],
        designation: json["Designation"],
      );

  Map<String, dynamic> toJson() => {
        "DesignationId": designationId,
        "Designation": designation,
      };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: JsonApiDropdown(),
    );
  }
}

class JsonApiDropdown extends StatefulWidget {
  @override
  JsonApiDropdownState createState() {
    return new JsonApiDropdownState();
  }
}

class JsonApiDropdownState extends State<JsonApiDropdown> {
  late Designations _currentDesignation;

  final String uri = 'https://jsonplaceholder.typicode.com/users';

  Future<List<Designations>> _fetchDesignation() async {
    String jsonString =
        '[ { "DesignationId": "CDG0008", "Designation": "Avp - Associate Vice President" }, { "DesignationId": "CDG0004", "Designation": "Ceo - Chief Executive Officer" }, { "DesignationId": "CDG0005", "Designation": "Ceko - Chief Executive Officer" } ]';
    final designations = designationsFromJson(jsonString);
    _currentDesignation = designations[0];
    return designations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetching data from JSON - DropdownButton'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FutureBuilder<List<Designations>>(
                future: _fetchDesignation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Designations>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<Designations>(
                    items: snapshot.data
                        ?.map((designation) => DropdownMenuItem<Designations>(
                              child: Text(designation.designation),
                              value: designation,
                            ))
                        .toList(),
                    onChanged: (Designations? value) {
                      setState(() {
                        _currentDesignation = value!;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,
                    hint: Text('Select User'),
                  );
                }),
            SizedBox(height: 20.0),
            _currentDesignation != null
                ? Text("designation: " +
                    _currentDesignation.designation +
                    "\n id: " +
                    _currentDesignation.designationId)
                : Text("No selected"),
          ],
        ),
      ),
    );
  }
}

