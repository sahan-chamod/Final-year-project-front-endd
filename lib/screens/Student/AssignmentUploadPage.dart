import 'package:flutter/material.dart';

class AssignmentUploadPage extends StatefulWidget {
  @override
  _AssignmentUploadPageState createState() => _AssignmentUploadPageState();
}

class _AssignmentUploadPageState extends State<AssignmentUploadPage> {
  // For file upload handling
  String? _selectedVoiceFile;
  String? _selectedDocument;

  List<String> _uploadedVoiceFiles = [];
  List<String> _uploadedDocuments = [];

  void _uploadVoiceFile() {
    // Implement logic for uploading voice file
    setState(() {
      _selectedVoiceFile = "Voice File Uploaded";
      _uploadedVoiceFiles.add(_selectedVoiceFile!);
    });
  }

  void _uploadDocument() {
    // Implement logic for uploading document
    setState(() {
      _selectedDocument = "Document Uploaded";
      _uploadedDocuments.add(_selectedDocument!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Assignment'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Upload your assignment:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _uploadVoiceFile,
              icon: Icon(Icons.mic),
              label: Text('Upload assignment Voice File'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade200,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            if (_selectedVoiceFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _selectedVoiceFile!,
                  style: TextStyle(color: Colors.teal.shade700),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _uploadDocument,
              icon: Icon(Icons.attach_file),
              label: Text('Upload assignment Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            if (_selectedDocument != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _selectedDocument!,
                  style: TextStyle(color: Colors.teal.shade200),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Uploaded assignment Voice Files:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 10),
            _buildVoiceFilesTable(),
            SizedBox(height: 20),
            Text(
              'Uploaded assignment Documents:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 10),
            _buildDocumentsTable(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Submit assignment logic
              },
              child: Text('Submit Assignment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }

  Widget _buildVoiceFilesTable() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Voice File',
            style: TextStyle(color: Colors.teal.shade700),
          ),
        ),
      ],
      rows: _uploadedVoiceFiles.map((file) {
        return DataRow(
          cells: [
            DataCell(Text(file)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDocumentsTable() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'Document',
            style: TextStyle(color: Colors.teal.shade700),
          ),
        ),
      ],
      rows: _uploadedDocuments.map((doc) {
        return DataRow(
          cells: [
            DataCell(Text(doc)),
          ],
        );
      }).toList(),
    );
  }
}
