import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class UpcomingAssignmentsPage extends StatefulWidget {
  @override
  _UpcomingAssignmentsPageState createState() =>
      _UpcomingAssignmentsPageState();
}

class _UpcomingAssignmentsPageState extends State<UpcomingAssignmentsPage> {
  List<Map<String, String>> voiceFiles =
      []; 
  bool isLoading = true;
  String errorMessage = '';
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  String currentAudioUrl = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize AudioPlayer
    fetchVoiceFiles();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose(); // Dispose of the player when done
  }

  // Function to fetch voice files from API
  Future<void> fetchVoiceFiles() async {
    try {
      // Fetch data from the API
      final response = await http.get(Uri.parse('http://20.2.250.40/voices'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Check if the 'files' key exists and is a list
        if (jsonResponse['files'] is List) {
          setState(() {
            // Store both file_path and filename in voiceFiles list
            voiceFiles = (jsonResponse['files'] as List)
                .map<Map<String, String>>((file) => {
                      'file_path': file['file_path'],
                      'filename': file['filename'],
                    })
                .toList();
            isLoading = false;
          });
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception(
            'Failed to load voice files. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching voice files: $e';
      });
    }
  }

  // Function to play or stop audio
  Future<void> _playAudio(String url) async {
    try {
      if (!mounted) return;

      if (isPlaying && currentAudioUrl == url) {
        await _audioPlayer.stop();
        if (mounted) {
          setState(() {
            isPlaying = false;
            currentAudioUrl = '';
          });
        }
      } else {
        await _audioPlayer.play(
          UrlSource(url),
          mode: PlayerMode.mediaPlayer, // Use mediaPlayer mode
        );
        if (mounted) {
          setState(() {
            isPlaying = true;
            currentAudioUrl = url;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Error playing audio: $e';
        });
      }
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Assignments & Voice Files'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAssignmentCard(
                        context,
                        subject: 'Math',
                        title: 'Algebra Homework',
                        dueDate: '2024-11-30',
                        description:
                            'Complete the algebra problems on page 45.',
                      ),
                      _buildVoiceFilesList(),
                    ],
                  ),
                ),
    );
  }

  // Build Assignment Card widget
  Widget _buildAssignmentCard(
    BuildContext context, {
    required String subject,
    required String title,
    required String dueDate,
    required String description,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade100,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.teal.shade300,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject: $subject',
              style: TextStyle(color: Colors.teal.shade300),
            ),
            Text(
              'Due Date: $dueDate',
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {},
      ),
    );
  }

  // Build the list of voice files
  Widget _buildVoiceFilesList() {
    return Column(
      children: [
        if (voiceFiles.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'No voice files available.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        else
          ...voiceFiles.map((file) {
            final String audioUrl =
                'http://20.2.250.40/voices/${file['file_path']}';
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              color: Colors.teal.shade100,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  file['filename']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.teal.shade300,
                  ),
                ),
                subtitle: Text(
                  isPlaying && currentAudioUrl == audioUrl
                      ? 'Playing...'
                      : 'Click to play or stop',
                  style: TextStyle(color: Colors.black87),
                ),
                onTap: () {
                  _playAudio(audioUrl);
                },
              ),
            );
          }).toList(),
      ],
    );
  }
}
