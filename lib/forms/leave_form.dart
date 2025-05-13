// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({super.key});

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();

  final departmentController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final dateOfFilingController = TextEditingController();
  final positionController = TextEditingController();
  final salaryController = TextEditingController();
  final vacationLocationController = TextEditingController();
  final abroadLocationController = TextEditingController();
  final sickHospitalIllnessController = TextEditingController();
  final sickOutPatientIllnessController = TextEditingController();
  final womenSpecialLeaveIllnessController = TextEditingController();
  final workingDaysAppliedController = TextEditingController();
  final inclusiveDatesController = TextEditingController();
  final signatureController = TextEditingController();

  bool commutationRequired = false;
  String? studyLeaveType;
  String? otherPurpose;
  final List<String> selectedLeaveTypes = [];

  final List<String> leaveTypes = [
    'Vacation',
    'Sick',
    'Maternity',
    'Paternity',
    'Study',
    'Solo Parent',
    'Special Leave Benefits for Women',
    'Others'
  ];

  @override
  void dispose() {
    departmentController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    dateOfFilingController.dispose();
    positionController.dispose();
    salaryController.dispose();
    vacationLocationController.dispose();
    abroadLocationController.dispose();
    sickHospitalIllnessController.dispose();
    sickOutPatientIllnessController.dispose();
    womenSpecialLeaveIllnessController.dispose();
    workingDaysAppliedController.dispose();
    inclusiveDatesController.dispose();
    signatureController.dispose();
    super.dispose();
  }

  Widget buildRoundedTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(fontFamily: 'Poppins', color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Leave Form',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildRoundedTextField(controller: departmentController, label: 'Department'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: lastNameController, label: 'Last Name'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: firstNameController, label: 'First Name'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: middleNameController, label: 'Middle Name'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: dateOfFilingController, label: 'Date of Filing'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: positionController, label: 'Position'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: salaryController, label: 'Salary'),
              const SizedBox(height: 24),

              const Text(
                'Type of Leave',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),

              ...leaveTypes.map((leave) => CheckboxListTile(
                    title: Text(leave, style: const TextStyle(fontFamily: 'Poppins')),
                    value: selectedLeaveTypes.contains(leave),
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          selectedLeaveTypes.add(leave);
                        } else {
                          selectedLeaveTypes.remove(leave);
                        }
                      });
                    },
                  )),

              const SizedBox(height: 16),

              if (selectedLeaveTypes.contains('Vacation')) ...[
                buildRoundedTextField(controller: vacationLocationController, label: 'Vacation Location'),
                const SizedBox(height: 16),
                buildRoundedTextField(controller: abroadLocationController, label: 'Abroad Location'),
                const SizedBox(height: 16),
              ],

              if (selectedLeaveTypes.contains('Sick')) ...[
                buildRoundedTextField(controller: sickHospitalIllnessController, label: 'Sick (In Hospital) Illness'),
                const SizedBox(height: 16),
                buildRoundedTextField(controller: sickOutPatientIllnessController, label: 'Sick (Out Patient) Illness'),
                const SizedBox(height: 16),
              ],

              if (selectedLeaveTypes.contains('Special Leave Benefits for Women')) ...[
                buildRoundedTextField(controller: womenSpecialLeaveIllnessController, label: "Women's Special Leave Illness"),
                const SizedBox(height: 16),
              ],

              if (selectedLeaveTypes.contains('Study')) ...[
                DropdownButtonFormField<String>(
                  value: studyLeaveType,
                  decoration: InputDecoration(
                    labelText: 'Study Leave Type',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins', color: Colors.black87),
                  items: ['Masters', 'BAR/Board Review']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type, style: const TextStyle(fontFamily: 'Poppins')),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => studyLeaveType = val),
                ),
                const SizedBox(height: 16),
              ],

              if (selectedLeaveTypes.contains('Others')) ...[
                DropdownButtonFormField<String>(
                  value: otherPurpose,
                  decoration: InputDecoration(
                    labelText: 'Other Purpose',
                    labelStyle: const TextStyle(fontFamily: 'Poppins'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  style: const TextStyle(fontFamily: 'Poppins', color: Colors.black87),
                  items: ['Monetization', 'Terminal Leave']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type, style: const TextStyle(fontFamily: 'Poppins')),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => otherPurpose = val),
                ),
                const SizedBox(height: 16),
              ],

              buildRoundedTextField(controller: workingDaysAppliedController, label: 'Working Days Applied'),
              const SizedBox(height: 16),
              buildRoundedTextField(controller: inclusiveDatesController, label: 'Inclusive Dates'),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Commutation Required', style: TextStyle(fontFamily: 'Poppins')),
                value: commutationRequired,
                onChanged: (val) => setState(() => commutationRequired = val),
              ),
              const SizedBox(height: 16),

              buildRoundedTextField(controller: signatureController, label: 'Signature of Applicant'),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
                  foregroundColor: const Color.fromRGBO(254, 249, 225, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Submit', style: TextStyle(fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
