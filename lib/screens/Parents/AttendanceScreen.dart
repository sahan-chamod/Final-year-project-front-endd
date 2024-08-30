import 'package:flutter/material.dart';
import '../Parents/models/attendance_record_model.dart'; // Import the model

class AttendanceScreen extends StatelessWidget {
  final List<AttendanceRecord> attendanceRecords;

  AttendanceScreen({required this.attendanceRecords});

  @override
  Widget build(BuildContext context) {
    int totalClasses = attendanceRecords.length;
    int presentCount =
        attendanceRecords.where((record) => record.status == 'Present').length;
    double attendancePercentage = (presentCount / totalClasses) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Attendance Summary
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total Attendance',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Present: $presentCount / $totalClasses',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Attendance Percentage: ${attendancePercentage.toStringAsFixed(1)}%',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    Icon(Icons.check_circle, color: Colors.green, size: 50),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Attendance Records
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  final record = attendanceRecords[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        record.status == 'Present' ? Icons.check : Icons.close,
                        color: record.status == 'Present'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(record.date),
                      subtitle: Text(record.status),
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
