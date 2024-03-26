import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  bool isLoading = true;
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL

    var url = "https://realtimedatasample-e890c-default-rtdb.firebaseio.com/" +
        "data.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        list.add(blogData["title"]);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeeksforGeeks"),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      list[index],
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
