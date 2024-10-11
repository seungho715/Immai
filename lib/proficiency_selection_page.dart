import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:immai/time_immersion_page.dart';

class ProficiencySelectionPage extends StatefulWidget {
  final String selectedLanguage;

  ProficiencySelectionPage({required this.selectedLanguage});

  @override
  _ProficiencySelectionPageState createState() => _ProficiencySelectionPageState();
}

class _ProficiencySelectionPageState extends State<ProficiencySelectionPage> {
  String? _selectedProficiency;
  String? _selectedFluency;
  final List<String> _proficiencies = ['Beginner', 'Proficient', 'Advanced', 'Expert'];
  final List<String> _fluencies = ['Tourist/Casual', 'Daily Life/Conversational', 'Native Speaker/Fluent'];

  Future<void> sendProficiencies() async {
    final response = await http.post(
      Uri.parse('http://localhost:3001/proficiencies'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'selectedLanguage': widget.selectedLanguage,
        'currentProficiency': _selectedProficiency!,
        'targetFluency': _selectedFluency!,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, you can navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeImmersionPage(
            selectedLanguage: widget.selectedLanguage,
            selectedProficiency: _selectedProficiency!,
          ),
        ),
      );
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to send proficiencies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey P3'),
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
              'How well do you already know this language?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedProficiency,
              hint: Text('Select proficiency'),
              isExpanded: true,
              items: _proficiencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProficiency = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'What is your target fluency for this language?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedFluency,
              hint: Text('Select fluency'),
              isExpanded: true,
              items: _fluencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFluency = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedProficiency != null && _selectedFluency != null) {
                  sendProficiencies();
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
