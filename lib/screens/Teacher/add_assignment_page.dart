import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';

class AssignmentUploadPage extends StatefulWidget {
  @override
  _AssignmentUploadPageState createState() => _AssignmentUploadPageState();
}

class _AssignmentUploadPageState extends State<AssignmentUploadPage> {
  FlutterSoundRecorder? _recorder;
  String? _recordedFilePath;
  bool _isRecording = false;
  String? _selectedVoiceFile;
  String? _selectedDocument;
  List<String> _uploadedVoiceFiles = [];
  List<String> _uploadedDocuments = [];

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    await _recorder!.openRecorder();
  }

  Future<void> _startRecording() async {
    PermissionStatus permissionStatus = await Permission.microphone.request();
    if (permissionStatus.isGranted) {
      try {
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/recorded_audio.aac';
        await _recorder!.startRecorder(toFile: path);
        setState(() {
          _isRecording = true;
          _recordedFilePath = path;
        });
      } catch (e) {
        print("Error starting recording: $e");
      }
    } else {
      print("Microphone permission not granted");
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  Future<void> _uploadVoiceFile() async {
    if (_recordedFilePath == null) {
      print("No recorded file to upload");
      return;
    }
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://20.2.250.40/speech_to_text'));
      request.files.add(await http.MultipartFile.fromPath(
        'audio',
        _recordedFilePath!,
        contentType: MediaType('audio', 'aac'),
      ));
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _selectedVoiceFile = "Voice File Uploaded";
          _uploadedVoiceFiles.add(_selectedVoiceFile!);
        });
      } else {
        print('Failed to upload voice file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading voice file: $e');
    }
  }

  Future<void> _uploadDocument() async {
    if (_selectedDocument == null) {
      print("No document selected to upload");
      return;
    }
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://20.2.250.40/convert'));
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        _selectedDocument!,
        contentType: MediaType('application', 'octet-stream'),
      ));
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _uploadedDocuments.add("Document Uploaded");
        });
      } else {
        String responseBody = await response.stream.bytesToString();
        print('Failed to upload document: ${response.statusCode}');
        print('Response Body: $responseBody');
      }
    } catch (e) {
      print('Error uploading document: $e');
    }
  }

  Future<void> _pickDocument() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'docx', 'txt']);
    if (file != null && file.files.isNotEmpty) {
      setState(() {
        _selectedDocument = file.files.first.path;
      });
    }
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Assignment'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isRecording ? _stopRecording : _startRecording,
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                label:
                    Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _uploadVoiceFile,
                icon: Icon(Icons.upload),
                label: Text('Upload Voice File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              if (_selectedVoiceFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _selectedVoiceFile!,
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Uploaded Voice Files:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildVoiceFilesTable(),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickDocument,
                icon: Icon(Icons.file_copy),
                label: Text('Pick Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _uploadDocument,
                icon: Icon(Icons.upload),
                label: Text('Upload Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              if (_selectedDocument != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Document: ${_selectedDocument!}',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              SizedBox(height: 20),
              Text(
                'Uploaded Documents:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildDocumentTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceFilesTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Voice File')),
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

  Widget _buildDocumentTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Document')),
      ],
      rows: _uploadedDocuments.map((file) {
        return DataRow(
          cells: [
            DataCell(Text(file)),
          ],
        );
      }).toList(),
    );
  }
}
