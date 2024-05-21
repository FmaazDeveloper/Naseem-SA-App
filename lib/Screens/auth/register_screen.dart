import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:naseem_sa/Screens/profile_screen.dart';
import 'package:naseem_sa/api/api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _selectedRole = 'tourist';

  String touristRole = 'tourist';
  String guideRole = 'guide';

  bool _isEmailValid(String email) {
    // Regular expression to validate email format
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Role selection with radio buttons
                const Text('Type:'),
                Row(
                  children: [
                    Radio<String>(
                      value: touristRole,
                      groupValue: _selectedRole,
                      onChanged: (value) =>
                          setState(() => _selectedRole = value!),
                    ),
                    const Text('Tourist'),
                    Radio<String>(
                      value: guideRole,
                      groupValue: _selectedRole,
                      onChanged: (value) =>
                          setState(() => _selectedRole = value!),
                    ),
                    const Text('Guide'),
                  ],
                ),
                // Name field with icon
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                    ),
                  ],
                ),
                // Email field with icon
                Row(
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else if (!_isEmailValid(value)) {
                            return 'Please enter a valid email address';
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
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) => _password = value!,
                      ),
                    ),
                  ],
                ),
                // Confirm password field
                Row(
                  children: [
                    const Icon(Icons.lock_outline),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (value) {
                          // if (value!.isEmpty) {
                          //   return 'Please confirm your password';
                          // } else if (_password != value) {
                          //   return 'Passwords do not match';
                          // }
                          return null;
                        },
                        onSaved: (value) => _confirmPassword = value!,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Register button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        Map<String, dynamic> requestBody = {
                          'name': _name,
                          'email': _email,
                          'password': _password,
                          'password_confirmation': _confirmPassword,
                          'role': _selectedRole,
                        };

                        Uri apiUrl =
                            Uri.parse(myUrl + 'api/register');
                        http.post(apiUrl, body: requestBody).then((response) {
                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration successful!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Registration failed. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }).catchError((error) {
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
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(pageIndex: 0),
    );
  }
}
