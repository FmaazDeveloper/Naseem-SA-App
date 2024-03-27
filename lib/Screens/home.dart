import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      title1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(body1),
                Container(
                  height: 250,
                  width: 600,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage('images/Riyadh.JPG'),
                        fit: BoxFit.cover),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      title2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(body2),
                Row(
                  children: [
                    Text(
                      title3,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(body3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
