import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class DocumentAnalysisPage extends StatefulWidget {
  @override
  _DocumentAnalysisPageState createState() => _DocumentAnalysisPageState();
}

class _DocumentAnalysisPageState extends State<DocumentAnalysisPage> {
  String? _selectedDocument1;
  String? _selectedDocument2;
  bool _isLoading = false;
  String? _comparisonResult;

  // Method to select document
  Future<void> _selectDocument(int documentNumber) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String fileContent = await file.readAsString();

      setState(() {
        if (documentNumber == 1) {
          _selectedDocument1 = fileContent;
        } else {
          _selectedDocument2 = fileContent;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document $documentNumber selected successfully!'),
        ),
      );
    }
  }

  // Method to compare documents
  Future<void> _compareDocuments() async {
    if (_selectedDocument1 == null || _selectedDocument2 == null) {
      // Display an error message if both documents are not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Both documents must be selected before comparison.'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _comparisonResult = null; // Reset comparison result during loading
    });

    try {
      // Check if documents are not empty
      if (_selectedDocument1!.isEmpty || _selectedDocument2!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'One or both documents are empty. Please select valid documents.'),
          ),
        );
        return;
      }

      // Log the selected documents content for debugging
      print("Document 1 Content: $_selectedDocument1");
      print("Document 2 Content: $_selectedDocument2");

      // Convert documents to base64 encoding
      String base64Document1 = base64Encode(utf8.encode(_selectedDocument1!));
      String base64Document2 = base64Encode(utf8.encode(_selectedDocument2!));

      // Log base64 encoding for debugging
      print('Base64 Document 1: $base64Document1');
      print('Base64 Document 2: $base64Document2');

      // Log the request body for debugging
      String requestBody = jsonEncode({
        'document1': base64Document1,
        'document2': base64Document2,
      });
      print('Request Body: $requestBody');

      // Make API request to compare documents
      final response = await http.post(
        Uri.parse('http://20.2.250.40/compare'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _comparisonResult =
              data['result'] ?? 'Comparison completed successfully!';
        });
      } else {
        // Log the response body for better error tracking
        print('Response Body: ${response.body}');
        setState(() {
          _comparisonResult =
              'Failed to compare documents. Status Code: ${response.statusCode}\nResponse Body: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _comparisonResult = 'Error: $e';
      });
      print('Error comparing documents: $e');
    } finally {
      setState(() {
        _isLoading =
            false; // Hide loading indicator after the comparison is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Analysis'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                CircularProgressIndicator()
              else
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDocument(1),
                      child: Text('Select Document 1'),
                    ),
                    SizedBox(height: 10),
                    if (_selectedDocument1 != null)
                      Text(
                        'Document 1 Selected!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _selectDocument(2),
                      child: Text('Select Document 2'),
                    ),
                    SizedBox(height: 10),
                    if (_selectedDocument2 != null)
                      Text(
                        'Document 2 Selected!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(height: 20),
                    if (_selectedDocument1 != null &&
                        _selectedDocument2 != null)
                      ElevatedButton(
                        onPressed: _compareDocuments,
                        child: Text('Compare Documents'),
                      ),
                  ],
                ),
              SizedBox(height: 20),
              if (_comparisonResult != null)
                Text(
                  'Comparison Result: $_comparisonResult',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
