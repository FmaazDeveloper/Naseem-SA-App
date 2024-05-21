import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/api/api.dart';

class ActivityScreen extends StatefulWidget {
  final int landmarkID;

  const ActivityScreen({
    Key? key,
    required this.landmarkID,
  }) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<dynamic> activities = [];

  @override
  void initState() {
    super.initState();
    fetchLandmarkDetails();
  }

  Future<void> fetchLandmarkDetails() async {
    try {
      final response = await http.get(Uri.parse(myUrl +
          'api/activities/${widget.landmarkID}')); // Replace with your API endpoint URL

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          activities = jsonData;
        });
      } else {
        throw Exception('Failed to fetch activity details');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(pageName: 'Activities'),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          final activity = activities[index];
          final String name = activity['name'] ?? '';
          final String description = activity['description'] ?? '';
          final String photoUrl = myUrl + activity['photo'];

          return ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                photoUrl,
                                width: 350,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
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
