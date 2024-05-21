import 'package:flutter/material.dart';
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:naseem_sa/screens/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email field with icon
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!,
                    ),
                  ),
                ],
              ),
              // Password field with icon
              Row(
                children: [
                  const Icon(Icons.lock),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                  ),
                ],
              ),
              // Login button
              ElevatedButton(
                onPressed: () {
                  // Validate the form fields
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Prepare the request body
                    Map<String, dynamic> requestBody = {
                      'email': _email,
                      'password': _password,
                    };

                    // Send the POST request to the API
                    Uri apiUrl = Uri.parse(myUrl + 'api/login');
                    http.post(apiUrl, body: requestBody).then((response) {
                      if (response.statusCode == 200) {
                        // Login successful
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login successful!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Save login state
                        _saveLoginState(_email);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      } else {
                        // Login failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Login failed. Please check your credentials.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }).catchError((error) {
                      // Error occurred while making the request
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'An error occurred. Please try again later.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    });
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(pageIndex: 0),
    );
  }

  Future<void> _saveLoginState(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}