import 'package:flutter/material.dart';

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  bool _showKeyboard = false;
  List<String> _words = ['I', 'am', 'a', 'baguette'];
  List<String> _sentence = ['', '', '', ''];

  void _toggleKeyboard() {
    setState(() {
      _showKeyboard = !_showKeyboard;
    });
  }

  void _handleDrop(String word, int index) {
    setState(() {
      _sentence[index] = word;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Writing 1'),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard),
            onPressed: _toggleKeyboard,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Translate the following:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Je suis un baguette',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (_showKeyboard)
              TextField(
                autofocus: true,
              ),
            if (!_showKeyboard) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _sentence.asMap().entries.map((entry) {
                  int index = entry.key;
                  String word = entry.value;
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: EdgeInsets.all(4.0),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    },
                    onAccept: (data) {
                      _handleDrop(data, index);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: _words.map((word) {
                  return Draggable<String>(
                    data: word,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        word,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    feedback: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          word,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Opacity(
                        opacity: 0.5,
                        child: Text(
                          word,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: () {
                // Handle Check button press
              },
              child: Text('Check'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
