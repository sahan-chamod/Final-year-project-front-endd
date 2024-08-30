class AttendanceRecord {
  final String date;
  final String status;

  AttendanceRecord({required this.date, required this.status});

  // Factory method to create an AttendanceRecord from a Map
  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      date: map['date'],
      status: map['status'],
    );
  }

  // Method to convert an AttendanceRecord to a Map
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'status': status,
    };
  }
}
