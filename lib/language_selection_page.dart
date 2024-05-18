import 'package:flutter/material.dart';
import 'proficiency_selection_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? _selectedLearningLanguage;
  String? _selectedNativeLanguage;
  final List<String> _languages = ['French', 'German', 'Spanish', 'Chinese'];

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
              onPressed: () {
                if (_selectedLearningLanguage != null) {
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
