import 'package:flutter/material.dart';

class GeneratePayrollPage extends StatefulWidget {
  @override
  _GeneratePayrollPageState createState() => _GeneratePayrollPageState();
}

class _GeneratePayrollPageState extends State<GeneratePayrollPage> {
  final _formKey = GlobalKey<FormState>();
  final _employeeNameController = TextEditingController();
  final _hoursWorkedController = TextEditingController();
  final _hourlyRateController = TextEditingController();
  double _totalPay = 0.0;

  void _generatePayroll() {
    if (_formKey.currentState!.validate()) {
      final employeeName = _employeeNameController.text;
      final hoursWorked = double.tryParse(_hoursWorkedController.text) ?? 0;
      final hourlyRate = double.tryParse(_hourlyRateController.text) ?? 0;

      setState(() {
        _totalPay = hoursWorked * hourlyRate;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payroll Generated'),
            content: Text(
              'Employee: $employeeName\nTotal Pay: \$${_totalPay.toStringAsFixed(2)}',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Payroll'),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _employeeNameController,
                decoration: InputDecoration(labelText: 'Employee Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hoursWorkedController,
                decoration: InputDecoration(labelText: 'Hours Worked'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours worked';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hourlyRateController,
                decoration: InputDecoration(labelText: 'Hourly Rate'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hourly rate';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generatePayroll,
                child: Text('Generate Payroll'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              if (_totalPay > 0)
                Text(
                  'Total Pay: \$${_totalPay.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
