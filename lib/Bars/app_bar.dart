import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class appBar extends StatelessWidget {
  const appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
        title: Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      'images/logo.png',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text('Home Page'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      'images/request-tourist-icon.png',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
