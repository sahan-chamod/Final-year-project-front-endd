import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMeetingPage extends StatefulWidget {
  @override
  _CreateMeetingPageState createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  List<Map<String, String>> _meetings = [];

  // Method to select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Method to select time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addMeeting(String title, String date, String time, String notes) {
    setState(() {
      _meetings.add({
        'title': title,
        'date': date,
        'time': time,
        'notes': notes,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    List<Map<String, String>> upcomingMeetings = _meetings
        .where(
            (meeting) => DateFormat.yMd().parse(meeting['date']!).isAfter(now))
        .toList();
    List<Map<String, String>> previousMeetings = _meetings
        .where(
            (meeting) => DateFormat.yMd().parse(meeting['date']!).isBefore(now))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meeting'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Meeting Title',
                        prefixIcon: Icon(Icons.title, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : 'Date: ${DateFormat.yMd().format(_selectedDate!)}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Select Date'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedTime == null
                                ? 'Select Time'
                                : 'Time: ${_selectedTime!.format(context)}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Select Time'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: 'Additional Notes',
                        prefixIcon: Icon(Icons.note, color: Colors.blueAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final title = _titleController.text;
                            final notes = _notesController.text;
                            final date = _selectedDate != null
                                ? DateFormat.yMd().format(_selectedDate!)
                                : 'Not selected';
                            final time = _selectedTime != null
                                ? _selectedTime!.format(context)
                                : 'Not selected';

                            _addMeeting(title, date, time, notes);

                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.check),
                        label: Text('Create Meeting'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Text('Upcoming Meetings',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Divider(),
              ...upcomingMeetings.map((meeting) => ListTile(
                    title: Text(meeting['title']!),
                    subtitle: Text(
                        '${meeting['date']} at ${meeting['time']}\nNotes: ${meeting['notes']}'),
                  )),
              if (upcomingMeetings.isEmpty)
                Center(child: Text('No upcoming meetings.')),
              SizedBox(height: 24.0),
              Text('Previous Meetings',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Divider(),
              ...previousMeetings.map((meeting) => ListTile(
                    title: Text(meeting['title']!),
                    subtitle: Text(
                        '${meeting['date']} at ${meeting['time']}\nNotes: ${meeting['notes']}'),
                  )),
              if (previousMeetings.isEmpty)
                Center(child: Text('No previous meetings.')),
            ],
          ),
        ),
      ),
    );
  }
}
