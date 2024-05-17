import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/Screens/landmarks_screen.dart';

class RegionScreen extends StatefulWidget {
  final int administrativeRegionID;

  const RegionScreen({required this.administrativeRegionID, Key? key})
      : super(key: key);

  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  List<dynamic> regions = [];

  @override
  void initState() {
    super.initState();
    fetchLandmarkDetails();
  }

  Future<void> fetchLandmarkDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'http://10.0.2.2:8000/api/regions/${widget.administrativeRegionID}')); // Replace with your API endpoint URL

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          regions = jsonData;
        });
      } else {
        throw Exception('Failed to fetch region details');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(pageName: 'Region Details'),
      ),
      body: ListView.builder(
        itemCount: regions.length,
        itemBuilder: (BuildContext context, int index) {
          final region = regions[index];
          final String name = region['name'] ?? '';
          final String cardDescription = region['card_description'] ?? '';
          final int id = region['id'] ?? '';
          // final String photoUrl = "http://10.0.2.2:8000/" + region['card_photo'];

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandmarkScreen(regionID: id),
                ),
              );
            },
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
                        cardDescription,
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
