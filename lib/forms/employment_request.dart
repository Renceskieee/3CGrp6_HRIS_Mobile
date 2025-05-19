import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hris_mobile/components/snackbar.dart';

class EmploymentRequestScreen extends StatefulWidget {
  const EmploymentRequestScreen({super.key});

  @override
  State<EmploymentRequestScreen> createState() =>
      _EmploymentRequestScreenState();
}

class _EmploymentRequestScreenState extends State<EmploymentRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String? _selectedEmploymentRequest;
  String? _submissionMessage;

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
      setState(() {
        _submissionMessage =
            'Request Submitted for $formattedDate (${_selectedEmploymentRequest!})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employment Request Form',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromRGBO(109, 35, 35, 1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(109, 35, 35, 1), Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Request Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(109, 35, 35, 1),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _pickDate,
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    labelStyle: const TextStyle(
                                      color: Color.fromRGBO(109, 35, 35, 1),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(109, 35, 35, 1),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(109, 35, 35, 1),
                                        width: 2,
                                      ),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.calendar_today,
                                      color: Color.fromRGBO(109, 35, 35, 1),
                                    ),
                                  ),
                                  validator:
                                      (value) =>
                                          _selectedDate == null
                                              ? 'Please select a date'
                                              : null,
                                  controller: TextEditingController(
                                    text:
                                        _selectedDate != null
                                            ? DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(_selectedDate!)
                                            : '',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Request Type',
                                labelStyle: const TextStyle(
                                  color: Color.fromRGBO(109, 35, 35, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(109, 35, 35, 1),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(109, 35, 35, 1),
                                    width: 2,
                                  ),
                                ),
                              ),
                              items:
                                  _employmentRequests
                                      .map(
                                        (type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(type),
                                        ),
                                      )
                                      .toList(),
                              value: _selectedEmploymentRequest,
                              onChanged: (value) {
                                setState(() {
                                  _selectedEmploymentRequest = value;
                                });
                              },
                              validator:
                                  (value) =>
                                      value == null
                                          ? 'Please select a request type'
                                          : null,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                    109,
                                    35,
                                    35,
                                    1,
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: _submitForm,
                                child: const Text(
                                  'Submit Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            if (_submissionMessage != null) ...[
                              const SizedBox(height: 25),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 25,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(109, 35, 35, 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color.fromRGBO(109, 35, 35, 1),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color.fromRGBO(109, 35, 35, 1),
                                      size: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _submissionMessage!,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(109, 35, 35, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Color.fromRGBO(109, 35, 35, 1),
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _submissionMessage = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
