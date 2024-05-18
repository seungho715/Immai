import 'package:flutter/material.dart';
import 'package:immai/home_page.dart';

class TimeImmersionPage extends StatefulWidget {
  final String selectedLanguage;

  TimeImmersionPage({required this.selectedLanguage});

  @override
  _TimeImmersionPageState createState() => _TimeImmersionPageState();
}

class _TimeImmersionPageState extends State<TimeImmersionPage> {
  final TextEditingController _timeController = TextEditingController();

  void _showImmersionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Phone Immersion Description'),
          content: Text(
            'Phone immersion mode allows for Immai to monitor your phone usage on a day to day basis and generate activities that are relevant to you. User data is confidential and is stored locally in the app.',
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey P4'),
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
          children: <Widget>[
            Text(
              'Selected language: ${widget.selectedLanguage}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'How much time do you want to spend learning each day?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter time in minutes',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text(
              'Enable phone immersion mode?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showImmersionMessage,
                  child: Text('Yes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle "No" button press
                  },
                  child: Text('No'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(_timeController.text.isNotEmpty){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => HomePage(),),
                  );
                }
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(fixedSize: Size(188, 47)),
            ),
          ],
        ),
      ),
    );
  }
}
