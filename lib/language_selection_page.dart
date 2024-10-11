import 'package:flutter/material.dart';
import 'proficiency_selection_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? _selectedLearningLanguage;
  String? _selectedNativeLanguage;
  final List<String> _languages = ['French', 'German', 'Spanish', 'Chinese'];

  Future<void> sendLanguageToBackend() async {
    final url = Uri.parse('http://localhost:3001/languages');
    print('Sending data to $url');
    print('Learning Language: $_selectedLearningLanguage, Native Language: $_selectedNativeLanguage');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'learningLanguage': _selectedLearningLanguage,
        'nativeLanguage': _selectedNativeLanguage,
      }),
    );

    if (response.statusCode == 200) {
      print('Languages sent successfully');
      print(response.body);
    } else {
      print('Failed to send languages. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey P2'),
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
              'What language do you want to learn?',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedLearningLanguage,
              hint: Text('Select language'),
              isExpanded: true,
              items: _languages.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLearningLanguage = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select native language',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedNativeLanguage,
              hint: Text('Select language'),
              isExpanded: true,
              items: _languages.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedNativeLanguage = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedLearningLanguage != null && _selectedNativeLanguage != null) {
                  await sendLanguageToBackend();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProficiencySelectionPage(
                        selectedLanguage: _selectedLearningLanguage!,
                      ),
                    ),
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
