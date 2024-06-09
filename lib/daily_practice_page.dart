import 'package:flutter/material.dart';
import 'writing_first_page.dart';

class DailyPracticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Practice 1'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'What would you like to practice?',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Recommended Exercises button press
                  },
                  child: Text('Recommended Exercises'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WritingPage()),
                    );
                  },
                  child: Text('Writing'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Reading button press
                  },
                  child: Text('Reading'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Listening button press
                  },
                  child: Text('Listening'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 60),
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
