import 'package:flutter/material.dart';
import 'daily_practice_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedTopic = "Topic: Alphabet";

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
      _selectedTopic = 'Topic: $topic';
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Text('J'),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.green,
                        ),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Text('20'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle Past Exercises button press
                      },
                      child: Text('Past Exercises'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Word Deck button press
                      },
                      child: Text('Word Deck'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.amber[100],
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Daily Practice Set',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _showTopicDialog,
                        child: Text(_selectedTopic),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Vocab button press
                        },
                        child: Text('Vocab'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Trivia button press
                        },
                        child: Text('Trivia'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DailyPracticePage()),
                          );
                        },
                        child: Text('Practice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.amber[100],
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Extra Exercises',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Chatting button press
                        },
                        child: Text('Chatting'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Karaoke button press
                        },
                        child: Text('Karaoke'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Writing Practice button press
                        },
                        child: Text('Writing Practice'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Handle News Flash button press
                        },
                        child: Text('News Flash'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle Menu button press
                      },
                      icon: Icon(Icons.menu),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Translator button press
                      },
                      child: Text('Translator'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Grammar button press
                      },
                      child: Text('Grammar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
