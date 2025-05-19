import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hris_mobile/components/snackbar.dart';

class EmploymentRequestScreen extends StatefulWidget {
  const EmploymentRequestScreen({super.key});

  @override
  State<EmploymentRequestScreen> createState() => _EmploymentRequestScreenState();
}

class _EmploymentRequestScreenState extends State<EmploymentRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String? _selectedEmploymentRequest;

  final List<String> _employmentRequests = [
    'Certificate of Employment (COE)',
    'Employment Verification',
    'Service Record',
    'Clearance Request',
    'ID or Badge Replacement',
  ];

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      showCustomSnackBar(
        context,
        'Request Submitted for $formattedDate (${_selectedEmploymentRequest!})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(109, 35, 35, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) =>
                        _selectedDate == null ? 'Please select a date' : null,
                    controller: TextEditingController(
                      text: _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                          : '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Request Type',
                  border: OutlineInputBorder(),
                ),
                items: _employmentRequests
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                value: _selectedEmploymentRequest,
                onChanged: (value) {
                  setState(() {
                    _selectedEmploymentRequest = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a request type' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(109, 35, 35, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
