import 'package:flutter/material.dart';

class DailyPracticeFirstPage extends StatefulWidget {
  @override
  _DailyPracticeFirstPageState createState() => _DailyPracticeFirstPageState();
}

class _DailyPracticeFirstPageState extends State<DailyPracticeFirstPage> {
  String _selectedTopic = "Basics lvl 1";

  void _showTopicDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Topics'),
          content: Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  _selectTopic('Auto Select');
                },
                child: Text('Auto Select'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _selectTopic('Random Mix');
                },
                child: Text('Random Mix'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              TextButton(onPressed: () { _selectTopic('Work'); }, child: Text('Work')),
              TextButton(onPressed: () { _selectTopic('Cafe'); }, child: Text('Cafe')),
              TextButton(onPressed: () { _selectTopic('School'); }, child: Text('School')),
              TextButton(onPressed: () { _selectTopic('Life'); }, child: Text('Life')),
              TextButton(onPressed: () { _selectTopic('Shopping'); }, child: Text('Shopping')),
              TextButton(onPressed: () { _selectTopic('Activities'); }, child: Text('Activities')),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectTopic(String topic) {
    setState(() {
      _selectedTopic = topic;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Daily Practice button press
                },
                child: Text('Daily Practice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  foregroundColor: Colors.black,
                  shape: StadiumBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Topics',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedTopic,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedTopic = newValue;
                        });
                      }
                    },
                    items: <String>[
                      'Auto Select',
                      'Random Mix',
                      'Work',
                      'Cafe',
                      'School',
                      'Life',
                      'Shopping',
                      'Activities'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black)),
                ),
                child: Text(
                  _selectedTopic,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle Target Practice button press
                },
                child: Text('Target Practice'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[300],
                  foregroundColor: Colors.black,
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DailyPracticeFirstPage(),
  ));
}
