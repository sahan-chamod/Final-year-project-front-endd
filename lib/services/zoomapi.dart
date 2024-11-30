import 'dart:convert';
import 'package:http/http.dart' as http;

class ZoomApiService {
  final String accessToken = 'SASajNsMSuWx20p8gB8vIA';

  // Method to create a Zoom meeting
  Future<Map<String, dynamic>> createMeeting(String topic, DateTime startTime,
      String duration, String timezone) async {
    final url = Uri.parse('https://api.zoom.us/v2/users/me/meetings');
    final headers = {
      'Authorization': 'Bearer $accessToken', // Using OAuth token
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'topic': topic,
      'type': 2, // Scheduled meeting
      'start_time': startTime.toUtc().toIso8601String(),
      'duration': duration, // Duration in minutes
      'timezone': timezone,
      'agenda': 'Discuss meeting agenda',
      'settings': {
        'host_video': true,
        'participant_video': true,
        'audio': 'voip',
        'auto_recording': 'cloud',
      },
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create meeting: ${response.body}');
    }
  }
}
