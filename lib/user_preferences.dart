import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Function to save user data into SharedPreferences
  Future<void> saveUserData(String firstName, String lastName, String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  // Function to get user data from SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'firstName': prefs.getString('firstName'),
      'lastName': prefs.getString('lastName'),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
    };
  }

  // Function to clear user data (on logout)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('username');
    await prefs.remove('email');
  }
}
