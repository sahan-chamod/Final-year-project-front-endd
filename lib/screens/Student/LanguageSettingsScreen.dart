import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatefulWidget {
  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  final List<Map<String, String>> languages = [
    {"code": "en", "name": "English"},
    {"code": "es", "name": "Spanish"},
    {"code": "fr", "name": "French"},
    {"code": "de", "name": "German"},
    {"code": "zh", "name": "Chinese"},
    {"code": "ja", "name": "Japanese"},
    {"code": "ru", "name": "Russian"},
    {"code": "pt", "name": "Portuguese"},
    {"code": "hi", "name": "Hindi"},
    {"code": "ar", "name": "Arabic"},
    {"code": "ko", "name": "Korean"},
    {"code": "it", "name": "Italian"},
    {"code": "nl", "name": "Dutch"},
    {"code": "tr", "name": "Turkish"},
    {"code": "pl", "name": "Polish"},
    {"code": "id", "name": "Indonesian"},
    {"code": "th", "name": "Thai"},
    {"code": "sv", "name": "Swedish"},
    {"code": "fi", "name": "Finnish"},
    {"code": "si", "name": "Sinhala"},
  ];

  String _selectedLanguageCode = "en";

  void _changeLanguage(String newLanguageCode) {
    setState(() {
      _selectedLanguageCode = newLanguageCode;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Language changed to ${newLanguageCode.toUpperCase()}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
        backgroundColor: Colors.teal.shade600,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.teal.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: RadioListTile<String>(
                title: Text(
                  language['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: _selectedLanguageCode == language['code']
                        ? Colors.teal.shade600
                        : Colors.black87,
                  ),
                ),
                value: language['code']!,
                groupValue: _selectedLanguageCode,
                onChanged: (String? value) {
                  _changeLanguage(value!);
                },
                activeColor: Colors.teal.shade600,
                tileColor: Colors.teal.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            );
          },
        ),
      ),
    );
  }
}
