import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:naseem_sa/Screens/contact_us_screen.dart';
import 'package:naseem_sa/Screens/home_screen.dart';
import 'package:naseem_sa/Screens/profile_screen.dart';
import 'package:naseem_sa/Screens/administrative_regions_screen.dart';

class BottomBar extends StatefulWidget {
  final int pageIndex;
  const BottomBar({super.key, required this.pageIndex});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> _screens = [
    ProfileScreen(),
    const HomeScreen(),
    const AdministrartiveRegionScreen(),
    ContactUsScreen(),
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
            GButton(icon: Icons.headset_mic, text: "Contact Us"),
          ],
        ),
      ),
    );
  }
}
