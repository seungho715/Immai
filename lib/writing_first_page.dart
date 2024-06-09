import 'package:flutter/material.dart';
import 'dart:math';
import 'writing_second_page.dart';

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  bool _showKeyboard = false;
  List<String> _words = ['I', 'am', 'a', 'baguette'];
  List<String> _sentence = ['', '', '', ''];
  List<String> _shuffledWords = [];
  int _currentIndex = -1;
  TextEditingController _textController = TextEditingController();
  String _feedbackMessage = '';
  Color _feedbackColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _shuffledWords = List.from(_words)..shuffle(Random());
  }

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

  void _handleTap(int index) {
    setState(() {
      _currentIndex = index;
      _textController.text = _sentence[index];
      _showKeyboard = true;
    });
  }

  void _handleTextChange(String value) {
    if (_currentIndex != -1) {
      setState(() {
        _sentence[_currentIndex] = value;
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      if (_sentence.join(' ') == 'I am a baguette') {
        _feedbackMessage = 'Correct!';
        _feedbackColor = Colors.green;
      } else {
        _feedbackMessage = 'Close but not quite\nCorrect answer: I am a baguette';
        _feedbackColor = Colors.red;
      }
    });
  }

  void _reset() {
    setState(() {
      _sentence = ['', '', '', ''];
      _shuffledWords.shuffle(Random());
      _feedbackMessage = '';
      _feedbackColor = Colors.transparent;
      _showKeyboard = false;
      _currentIndex = -1;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WritingSecondPage()),
    );
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
              'Je suis une baguette',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (_showKeyboard)
              TextField(
                controller: _textController,
                autofocus: true,
                onChanged: _handleTextChange,
                onSubmitted: (_) {
                  setState(() {
                    _showKeyboard = false;
                    _currentIndex = -1;
                  });
                },
              ),
            if (!_showKeyboard) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _sentence.asMap().entries.map((entry) {
                  int index = entry.key;
                  String word = entry.value;
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return GestureDetector(
                        onTap: () => _handleTap(index),
                        child: Container(
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
                children: _shuffledWords.map((word) {
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
              onPressed: _checkAnswer,
              child: Text('Check'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
              ),
            ),
            if (_feedbackMessage.isNotEmpty) ...[
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                color: _feedbackColor,
                child: Text(
                  _feedbackMessage,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _reset,
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WritingPage(),
  ));
}
