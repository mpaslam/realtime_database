import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_database/read_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealTime Database',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("GeeksforGeeks"),
        ),
        body: WriteDataForm(),
      ),
    );
  }
}

class WriteDataForm extends StatefulWidget {
  @override
  _WriteDataFormState createState() => _WriteDataFormState();
}

class _WriteDataFormState extends State<WriteDataForm> {
  final _form = GlobalKey<FormState>();
  late String title;

  void writeData() async {
    _form.currentState?.save();

    // Please replace the Database URL
    // which we will get in “Add Realtime
    // Database” step with DatabaseURL
    var url = "https://realtimedatasample-e890c-default-rtdb.firebaseio.com/" +
        "data.json";

    // (Do not remove “data.json”,keep it as it is)
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"title": title}),
      );
    } catch (error) {
      throw error;
    }
  }

  void navigateToReadDataPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadData()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Enter Title"),
              onSaved: (value) {
                title = value!;
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: writeData,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text(
                "Submit",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToReadDataPage(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text(
                "Read Data",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
