import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class AssignmentUploadPage extends StatefulWidget {
  const AssignmentUploadPage({super.key});

  @override
  State<AssignmentUploadPage> createState() => _AssignmentUploadPageState();
}

class _AssignmentUploadPageState extends State<AssignmentUploadPage> {
  final List<String> uploadedVoiceFiles = [];
  final List<String> uploadedDocumentFiles = [];
  String uploadStatus = '';
  bool isUploading = false;
  String? selectedFilePath;

  @override
  void initState() {
    super.initState();
    uploadStatus = 'No file selected';
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Handle voice file upload
  Future<void> handleVoiceFileUpload() async {
    if (isUploading) return;

    setState(() {
      isUploading = true;
      uploadStatus = 'Selecting file...';
    });

    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['wav', 'mp3', 'm4a'],
      );

      if (result == null || result.files.isEmpty) {
        setState(() {
          uploadStatus = 'No file selected';
          isUploading = false;
        });
        return;
      }

      final fileInfo = result.files.single;
      final String? filePath = fileInfo.path; // Correctly accessing the file path

      if (filePath == null) {
        setState(() {
          uploadStatus = 'Invalid file path';
          isUploading = false;
        });
        return;
      }

      final File file = File(filePath);
      final String fileName = file.path.split('/').last;

      final int fileSizeInMB = file.lengthSync() ~/ (1024 * 1024); // size in MB
      if (fileSizeInMB > 10) {
        setState(() {
          uploadStatus = 'File is too large. Max size is 10MB.';
          isUploading = false;
        });
        return;
      }

      setState(() {
        uploadStatus = 'Uploading $fileName...';
        selectedFilePath = filePath;
      });

      // Prepare upload request for voice files
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://20.2.250.40/speech_to_text'),
      );

      // Attach the file correctly with the field name 'audio'
      request.files.add(
        await http.MultipartFile.fromPath('audio', filePath),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      final streamedResponse = await request.send().timeout(
        const Duration(minutes: 2),
        onTimeout: () {
          throw TimeoutException('Upload timed out');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        setState(() {
          uploadStatus = 'Successfully uploaded $fileName';
          uploadedVoiceFiles.add(fileName);
        });
      } else {
        setState(() {
          uploadStatus = 'Upload failed: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        uploadStatus = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  // Handle document upload
  Future<void> handleDocumentUpload() async {
    if (isUploading) return;

    setState(() {
      isUploading = true;
      uploadStatus = 'Selecting document...';
    });

    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result == null || result.files.isEmpty) {
        setState(() {
          uploadStatus = 'No document selected';
          isUploading = false;
        });
        return;
      }

      final fileInfo = result.files.single;
      final String? filePath = fileInfo.path; // Correctly accessing the file path

      if (filePath == null) {
        setState(() {
          uploadStatus = 'Invalid file path';
          isUploading = false;
        });
        return;
      }

      final File file = File(filePath);
      final String fileName = file.path.split('/').last;

      final int fileSizeInMB = file.lengthSync() ~/ (1024 * 1024); // size in MB
      if (fileSizeInMB > 10) {
        setState(() {
          uploadStatus = 'File is too large. Max size is 10MB.';
          isUploading = false;
        });
        return;
      }

      setState(() {
        uploadStatus = 'Uploading $fileName...';
        selectedFilePath = filePath;
      });

      // Prepare upload request for document files
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://20.2.250.40/convert'),
      );

      // Attach the file correctly with the field name 'document'
      request.files.add(
        await http.MultipartFile.fromPath('document', filePath),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      final streamedResponse = await request.send().timeout(
        const Duration(minutes: 2),
        onTimeout: () {
          throw TimeoutException('Upload timed out');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        setState(() {
          uploadStatus = 'Successfully uploaded $fileName';
          uploadedDocumentFiles.add(fileName);
        });
      } else {
        setState(() {
          uploadStatus = 'Upload failed: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        uploadStatus = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Assignment'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isUploading ? null : handleVoiceFileUpload,
                icon: isUploading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.mic),
                label: Text(
                  isUploading ? 'Uploading Voice...' : 'Upload Assignment Voice File',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  disabledBackgroundColor: Colors.teal.shade100,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: isUploading ? null : handleDocumentUpload,
                icon: isUploading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.insert_drive_file),
                label: Text(
                  isUploading ? 'Uploading Document...' : 'Upload Assignment Document',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  disabledBackgroundColor: Colors.teal.shade100,
                ),
              ),
              const SizedBox(height: 16),
              if (uploadStatus.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: uploadStatus.startsWith('Error')
                          ? Colors.red.shade300
                          : Colors.teal.shade200,
                    ),
                  ),
                  child: Text(
                    uploadStatus,
                    style: TextStyle(
                      color: uploadStatus.startsWith('Error')
                          ? Colors.red.shade700
                          : Colors.teal.shade700,
                    ),
                  ),
                ),
              if (uploadedVoiceFiles.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Uploaded Voice Files:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: uploadedVoiceFiles.length,
                    itemBuilder: (context, index) {
                      final fileName = uploadedVoiceFiles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.audio_file,
                            color: Colors.teal.shade300,
                          ),
                          title: Text(fileName),
                          subtitle: Text(
                            'Uploaded successfully',
                            style: TextStyle(
                              color: Colors.teal.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (uploadedDocumentFiles.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Uploaded Document Files:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: uploadedDocumentFiles.length,
                    itemBuilder: (context, index) {
                      final fileName = uploadedDocumentFiles[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Icon(
                            Icons.insert_drive_file,
                            color: Colors.teal.shade300,
                          ),
                          title: Text(fileName),
                          subtitle: Text(
                            'Uploaded successfully',
                            style: TextStyle(
                              color: Colors.teal.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      backgroundColor: Colors.teal.shade50,
    );
  }
}
