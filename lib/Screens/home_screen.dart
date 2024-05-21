import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/Screens/regions_screen.dart';
// import 'package:naseem_sa/api/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageUrls = [
    'images/administrative_regions/Riyadh.png',
    'images/administrative_regions/Makkah.png',
    'images/administrative_regions/AL Madinah AL Munawwarah.png',
    'images/administrative_regions/Al-Qassim.png',
    'images/administrative_regions/Alsharqia.png',
    'images/administrative_regions/Asir.png',
    'images/administrative_regions/Tabuk.png',
    'images/administrative_regions/Hail.png',
    'images/administrative_regions/Alhudud Alshamalia.png',
    'images/administrative_regions/Jazan.png',
    'images/administrative_regions/Najran.png',
    'images/administrative_regions/Al-Baha.png',
    'images/administrative_regions/Aljawf.png',
  ];

  @override
  void initState() {
    super.initState();
    // fetchImageUrls();
  }

  // Future<void> fetchImageUrls() async {
  //   try {
  //     final response =
  //         await http.get(Uri.parse(myUrl + 'api/administrative_regions'));
  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       setState(() {
  //         imageUrls = List<String>.from(jsonData['photo'] as List<dynamic>);
  //       });
  //     } else {
  //       throw Exception('Failed to fetch image data');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var titleStyle = const TextStyle(
        fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);
    var bodyStyle = const TextStyle(fontSize: 18, color: Colors.black54);
    String title1 = "Tourism in the Kingdom of Saudi Arabia";
    String body1 =
        "It is one of the emerging sectors with rapid growth, and represents one of the important axes of the Saudi Vision 2030. Saudi Arabia is considered a tourist attraction thanks to its ancient history and heritage, exciting outdoor activities, and lots of delicious local cuisine.";
    String title2 = "Tourism in the cities of the Kingdom";
    String body2 =
        "Tourism in the Kingdom of Saudi Arabia is considered one of the emerging sectors and is one of the most important economic pillars in the country. Saudi Arabia is distinguished by its cultural and natural diversity, in addition to being the cradle of the Islamic religion, which makes it a tourist attraction.";
    String title3 = "Tourism in the Kingdom's islands";
    String body3 =
        "The Kingdom of Saudi Arabia enjoys a group of wonderful islands, estimated at approximately 1,285 islands, distributed between the Red Sea and the Arabian Gulf. These islands vary between sandy, volcanic and coral islands, and are characterized by high mountainous terrain and picturesque natural landscapes.";

    return Scaffold(
      appBar: AppBar(
        title: const MyAppBar(pageName: 'Home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(title1, style: titleStyle),
                    ),
                  ],
                ),
                Text(body1, style: bodyStyle),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: AnotherCarousel(
                    onImageTap: (index) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegionScreen(administrativeRegionID: index + 1),
                        ),
                      );
                    },
                    images: imageUrls
                        .map((url) => Image.asset(url, fit: BoxFit.cover))
                        .toList(),
                    dotSize: 6,
                    indicatorBgPadding: 0,
                  ),
                ),
                Row(
                  children: [
                    Flexible(child: Text(title2, style: titleStyle)),
                  ],
                ),
                Text(body2, style: bodyStyle),
                Row(
                  children: [
                    Flexible(child: Text(title3, style: titleStyle)),
                  ],
                ),
                Text(body3, style: bodyStyle),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(pageIndex: 1),
    );
  }
}
