import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportGenerationScreen extends StatefulWidget {
  @override
  _ReportGenerationScreenState createState() => _ReportGenerationScreenState();
}

class _ReportGenerationScreenState extends State<ReportGenerationScreen> {
  DateTimeRange? _selectedDateRange;
  String _reportType = 'Attendance';
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  void _generateReport() {
    // Logic to generate the report based on selected date range and report type
    // For demonstration, we'll show a simple dialog with the selected details

    if (_selectedDateRange == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date range')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Generated'),
        content: Text(
          'Report Type: $_reportType\n'
          'Date Range: ${_dateFormat.format(_selectedDateRange!.start)} - ${_dateFormat.format(_selectedDateRange!.end)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Report'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Generate a Report',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _reportType,
              decoration: InputDecoration(
                labelText: 'Select Report Type',
                border: OutlineInputBorder(),
              ),
              items: ['Attendance', 'Grades', 'Behavior']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _reportType = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Select Date Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDateRange == null
                        ? 'No date range selected'
                        : 'Date Range: ${_dateFormat.format(_selectedDateRange!.start)} - ${_dateFormat.format(_selectedDateRange!.end)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _selectDateRange,
                  child: Text('Select Dates'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _generateReport,
                child: Text('Generate Report'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
