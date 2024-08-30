import 'package:flutter/material.dart';

class ParentsMeetingPage extends StatelessWidget {
  // Example data with both upcoming and previous meetings
  final List<Map<String, String>> meetings = [
    {
      'date': '2024-09-01',
      'time': '10:00 AM',
      'teacher': 'Ms. Johnson',
      'subject': 'Math',
    },
    {
      'date': '2024-09-02',
      'time': '2:00 PM',
      'teacher': 'Mr. Smith',
      'subject': 'Science',
    },
    {
      'date': '2024-09-03',
      'time': '1:00 PM',
      'teacher': 'Mrs. Brown',
      'subject': 'English',
    },
    {
      'date': '2024-07-15',
      'time': '11:00 AM',
      'teacher': 'Mr. White',
      'subject': 'History',
    },
    {
      'date': '2024-06-20',
      'time': '9:00 AM',
      'teacher': 'Ms. Black',
      'subject': 'Geography',
    },
  ];

  // Helper function to split meetings into upcoming and previous
  List<Map<String, String>> _getUpcomingMeetings() {
    final today = DateTime.now();
    return meetings.where((meeting) {
      final meetingDate = DateTime.parse(meeting['date']!);
      return meetingDate.isAfter(today);
    }).toList();
  }

  List<Map<String, String>> _getPreviousMeetings() {
    final today = DateTime.now();
    return meetings.where((meeting) {
      final meetingDate = DateTime.parse(meeting['date']!);
      return meetingDate.isBefore(today);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final upcomingMeetings = _getUpcomingMeetings();
    final previousMeetings = _getPreviousMeetings();

    return Scaffold(
      appBar: AppBar(
        title: Text('Parent-Teacher Meetings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Upcoming Meetings Section
            Text(
              'Upcoming Meetings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: upcomingMeetings.length,
                itemBuilder: (context, index) {
                  final meeting = upcomingMeetings[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.event, color: Colors.blueAccent),
                      title: Text(
                          '${meeting['subject']} with ${meeting['teacher']}'),
                      subtitle: Text(
                          'Date: ${meeting['date']}, Time: ${meeting['time']}'),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.blueAccent),
                      onTap: () {
                        // Implement meeting details page or confirmation
                      },
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Previous Meetings Section
            Text(
              'Previous Meetings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: previousMeetings.length,
                itemBuilder: (context, index) {
                  final meeting = previousMeetings[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.event, color: Colors.grey),
                      title: Text(
                          '${meeting['subject']} with ${meeting['teacher']}'),
                      subtitle: Text(
                          'Date: ${meeting['date']}, Time: ${meeting['time']}'),
                      trailing:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        // Implement meeting details page or confirmation
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
