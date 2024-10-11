import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'language_selection_page.dart';


class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isNextButtonEnabled = false;
  String? _errorMessage;

  void _updateNextButtonState() {
    setState(() {
      _isNextButtonEnabled = _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _usernameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  // Check if username exists in the database
  Future<bool> _checkUsernameExists(String username) async {
    final url = Uri.parse('http://localhost:3001/api/users/username');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> usernames = json.decode(response.body);
      return usernames.any((user) => user['username'] == username);
    } else {
      throw Exception('Failed to check username');
    }
  }

  // Function to handle the Next button press
 // Function to register a new user
Future<void> _registerUser() async {
  final url = Uri.parse('http://localhost:3001/api/register'); // Your backend URL
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'email': _emailController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully registered, proceed to next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
      );
    } else if (response.statusCode == 409) {
      // Username exists
      setState(() {
        _errorMessage = jsonDecode(response.body)['error'];
      });
    } else {
      // Other error
      setState(() {
        _errorMessage = 'Failed to register user';
      });
    }
  } catch (error) {
    setState(() {
      _errorMessage = 'Error connecting to server: $error';
    });
  }
}

Future<void> _handleNextButton() async {
  final usernameExists = await _checkUsernameExists(_usernameController.text);

  if (usernameExists) {
    // Show popup if the username exists
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Username already exists'),
          content: Text('The username "${_usernameController.text}" is already taken.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // Call the registration function to submit data to the backend
    await _registerUser();
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a user profile'),
        actions: [
          TextButton(
            onPressed: _isNextButtonEnabled ? _handleNextButton : null,
            child: Text(
              'Next',
              style: TextStyle(
                color: _isNextButtonEnabled ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 10),
            ],
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'First name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _isNextButtonEnabled ? _handleNextButton : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isNextButtonEnabled ? Colors.green : Colors.grey, // Green if enabled, grey if disabled
                fixedSize: Size(188, 47),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateNextButtonState);
    _lastNameController.addListener(_updateNextButtonState);
    _usernameController.addListener(_updateNextButtonState);
    _emailController.addListener(_updateNextButtonState);
    _passwordController.addListener(_updateNextButtonState);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
