import 'package:flutter/material.dart';
import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';

class contactUs extends StatelessWidget {
  const contactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const MyAppBar(pageName: 'Contact Us',),
        ),
      bottomNavigationBar: const bottomBar(pageIndex: 3),
    );
  }
}
