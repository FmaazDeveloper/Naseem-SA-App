import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String pageName;
  const MyAppBar({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/logo.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(pageName),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  'images/request-tourist-icon.png',
                  height: 35,
                  width: 35,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
