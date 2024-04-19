import 'package:flutter/material.dart';
import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';

class touristPlaces extends StatelessWidget {
  const touristPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic items = const [
      "images/Abha.jpg",
      "images/Dammam.jpeg",
      "images/Diriyah.jpg",
      "images/Abha.jpg",
      "images/Dammam.jpeg",
      "images/Diriyah.jpg",
    ];
    return Scaffold(
      appBar: AppBar(
          title: const MyAppBar(pageName: 'Tourist places',),
        ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Image(
                image: AssetImage(items[index]),
                width: 300,
                height: 150,
                fit: BoxFit.fill),
          );
        },
      ),
      bottomNavigationBar: const bottomBar(pageIndex: 2),
    );
  }
}
