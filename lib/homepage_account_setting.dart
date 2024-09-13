import 'package:flutter/material.dart';

class HomepageAccountSetting extends StatefulWidget {
  @override
  _HomepageAccountSettingState createState() => _HomepageAccountSettingState();
}

class _HomepageAccountSettingState extends State<HomepageAccountSetting> {
  // You can initialize these with values from a database or API
  String username = 'TheAsianCow';
  String firstName = 'Jeffrey';
  String lastName = 'Huang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User profile picture (placeholder with initials)
            CircleAvatar(
              radius: 40,
              child: Text(
                'J',
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(height: 10),
            
            // Username display
            Text(
              username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // First name and last name fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First name
                Column(
                  children: [
                    Text('First name'),
                    SizedBox(height: 5),
                    Text(firstName, style: TextStyle(fontSize: 18)),
                  ],
                ),
                // Last name
                Column(
                  children: [
                    Text('Last name'),
                    SizedBox(height: 5),
                    Text(lastName, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Change Profile Pic button
            ElevatedButton(
              onPressed: () {
                // Logic to change profile picture
              },
              child: Text('Change Profile Pic'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                minimumSize: Size(200, 40),
              ),
            ),
            SizedBox(height: 20),

            // Confirm button
            ElevatedButton(
              onPressed: () {
                // Logic to confirm the changes
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomepageAccountSetting(),
  ));
}
