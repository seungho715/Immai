import 'package:flutter/material.dart';
import 'dart:math';

class WritingSecondPage extends StatefulWidget {
  @override
  _WritingSecondPageState createState() => _WritingSecondPageState();
}

class _WritingSecondPageState extends State<WritingSecondPage> {
  bool _showKeyboard = false;
  List<String> _words = ['beau', 'belle', 'pluit'];
  String _sentence = '';
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

  void _handleDrop(String word) {
    setState(() {
      _sentence = word;
    });
  }

  void _handleTap() {
    setState(() {
      _currentIndex = 0;
      _textController.text = _sentence;
      _showKeyboard = true;
    });
  }

  void _handleTextChange(String value) {
    if (_currentIndex != -1) {
      setState(() {
        _sentence = value;
      });
    }
  }

  void _checkAnswer() {
    setState(() {
      if (_sentence == 'beau') {
        _feedbackMessage = 'Correct!';
        _feedbackColor = Colors.green;
      } else {
        _feedbackMessage = 'Not quite\nCorrect answer: Il fait beau aujourd’hui';
        _feedbackColor = Colors.red;
      }
    });
  }

  void _reset() {
    setState(() {
      _sentence = '';
      _shuffledWords.shuffle(Random());
      _feedbackMessage = '';
      _feedbackColor = Colors.transparent;
      _showKeyboard = false;
      _currentIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the blank:'),
        actions: [
          IconButton(
            icon: Icon(Icons.keyboard),
            onPressed: _toggleKeyboard,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Fill in the blank:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  children: [
                    TextSpan(text: 'Il fait '),
                    if (!_showKeyboard)
                      WidgetSpan(
                        child: DragTarget<String>(
                          builder: (context, candidateData, rejectedData) {
                            return GestureDetector(
                              onTap: _handleTap,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.black)),
                                ),
                                child: Text(
                                  _sentence,
                                  style: TextStyle(fontSize: 24, color: Colors.black),
                                ),
                              ),
                            );
                          },
                          onAccept: (data) {
                            _handleDrop(data);
                          },
                        ),
                      ),
                    if (_showKeyboard)
                      WidgetSpan(
                        child: Container(
                          width: 100,
                          child: TextField(
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
                        ),
                      ),
                    TextSpan(text: ' aujourd’hui'),
                  ],
                ),
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WritingSecondPage(),
  ));
}
