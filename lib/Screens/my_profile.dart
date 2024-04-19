import 'package:flutter/material.dart';
import 'package:naseem_sa/Bars/app_bar.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';

class myProfile extends StatelessWidget {
  const myProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const MyAppBar(pageName: 'My Profile',),
        ),
      bottomNavigationBar: const bottomBar(pageIndex: 0),
    );
  }
}
