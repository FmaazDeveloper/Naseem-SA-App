import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';

class LandmarkScreen extends StatefulWidget {
  final int regionID;

  const LandmarkScreen({required this.regionID, Key? key}) : super(key: key);

  @override
  _LandmarkScreenState createState() => _LandmarkScreenState();
}

class _LandmarkScreenState extends State<LandmarkScreen> {
  List<dynamic> landmarks = [];

  @override
  void initState() {
    super.initState();
    fetchLandmarkDetails();
  }

  Future<void> fetchLandmarkDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/api/landmarks/${widget.regionID}')); // Replace with your API endpoint URL

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          landmarks = jsonData;
        });
      } else {
        throw Exception('Failed to fetch landmark details');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(pageName: 'Landmark Details'),
      ),
      body: ListView.builder(
        itemCount: landmarks.length,
        itemBuilder: (BuildContext context, int index) {
          final landmark = landmarks[index];
          final String name = landmark['name'] ?? '';
          final String description = landmark['description'] ?? '';
          // final String photoUrl = "http://10.0.2.2:8000/" + landmark['photo'];

          return ListTile(
            // leading: Image.network(
            //   photoUrl,
            //   width: 50,
            //   height: 50,
            //   fit: BoxFit.cover,
            // ),
            title: Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(pageIndex: 2),
    );
  }
}
