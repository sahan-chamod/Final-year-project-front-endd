// lib/model/payment_model.dart
class Payment {
  final String teacherName;
  final double amount;
  final DateTime date;

  Payment(
      {required this.teacherName, required this.amount, required this.date});
}
