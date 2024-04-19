import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:naseem_sa/Screens/contact_us.dart';
import 'package:naseem_sa/Screens/home.dart';
import 'package:naseem_sa/Screens/my_profile.dart';
import 'package:naseem_sa/Screens/tourist_places.dart';

class bottomBar extends StatefulWidget {
  final int pageIndex;
  const bottomBar({super.key,required this.pageIndex});
  @override
  State<bottomBar> createState() => _bottomBarState();
}
class _bottomBarState extends State<bottomBar> {
  final List<Widget> _screens = const [
    myProfile(),
    home(),
    touristPlaces(),
    contactUs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade900,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          gap: 8,
          color: Colors.white,
          activeColor: Colors.green,
          tabBackgroundColor: Colors.grey.shade100,
          padding: const EdgeInsets.all(8),
          onTabChange: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _screens[index]),
            );
          },
          selectedIndex: widget.pageIndex,
          tabs: const [
            GButton(icon: Icons.person, text: "My Profile"),
            GButton(icon: Icons.home, text: "Home Page"),
            GButton(icon: Icons.map, text: "Tourist places"),
            GButton(icon: Icons.support_agent, text: "Contact Us"),
          ],
        ),
      ),
    );
  }
}
