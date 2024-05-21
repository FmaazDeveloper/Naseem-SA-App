import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/Screens/auth/login_screen.dart';
import 'package:naseem_sa/Screens/auth/register_screen.dart';
import 'package:naseem_sa/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;
  String? _email;
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    setState(() {
      _isLoggedIn = email != null && email.isNotEmpty;
      _email = email;
    });

    if (_isLoggedIn) {
      await _fetchUserProfile();
    }
  }

  Future<void> _fetchUserProfile() async {
    Uri apiUrl = Uri.parse(myUrl + 'api/profile/$_email');

    try {
      http.Response response =
          await http.get(apiUrl).timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.length >= 2) {
          Map<String, dynamic> userProfile = jsonResponse[0][0];
          Map<String, dynamic> user = jsonResponse[1][0];

          setState(() {
            _userProfile = {
              ...userProfile,
              'name': user['name'],
            };
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch user profile.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on SocketException catch (e) {
      // Handle _ClientSocketException (Connection timed out)
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Connection timed out. Please check your network connection.'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred while fetching the user profile.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');

    setState(() {
      _isLoggedIn = false;
      _email = null;
      _userProfile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logged out successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (_isLoggedIn)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: _logout,
            ),
        ],
      ),
      body: Center(
        child: _isLoggedIn
            ? _userProfile != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          myUrl + _userProfile!['photo'],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Name: ${_userProfile!['name']}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Phone Number: ${_userProfile!['phone_number']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Age: ${_userProfile!['age']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Gender: ${_userProfile!['gender']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nationality: ${_userProfile!['nationality']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Language: ${_userProfile!['language']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Login',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Register',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: const BottomBar(pageIndex: 0),
    );
  }
}
