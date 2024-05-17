import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naseem_sa/Bars/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int? _selectedContactReasonId;
  bool _isSubmitting = false;
  bool _isLoggedIn = false;
  List<Map<String, dynamic>> _contactReasons = [];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _fetchContactReasons();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final _email = prefs.getString('email');
    setState(() {
      _isLoggedIn = _email != null;
    });
  }

  Future<void> _fetchContactReasons() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/contact_us'));
    if (response.statusCode == 200) {
      setState(() {
        _contactReasons = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      _showSnackBar('Error fetching contact reasons', Colors.red);
    }
  }

  void _showSnackBar(String message, [Color color = Colors.green]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitContactForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final prefs = await SharedPreferences.getInstance();
      final _email = prefs.getString('email');

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/contact_us/$_email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': _titleController.text,
          'message': _messageController.text,
          'contact_reason_id': _selectedContactReasonId,
          'email': _email,
        }),
      );

      if (response.statusCode == 200) {
        _showSnackBar('Message sent successfully');
        _titleController.clear();
        _messageController.clear();
        setState(() {
          _selectedContactReasonId = null;
          _isSubmitting = false;
        });
      } else {
        _showSnackBar('Error submitting message', Colors.red);
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us')),
      body: _isLoggedIn
          ? Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownButtonFormField<int>(
                      value: _selectedContactReasonId,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedContactReasonId = newValue;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Contact Reason'),
                      items: _contactReasons
                          .map((reason) => DropdownMenuItem<int>(
                                value: reason['id'],
                                child: Text(reason['name']),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a contact reason';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitContactForm,
                      child: _isSubmitting
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Submit'),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 64.0),
                  SizedBox(height: 16.0),
                  Text(
                    'Please log in to access the Contact Us feature',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const BottomBar(pageIndex: 3),
    );
  }
}