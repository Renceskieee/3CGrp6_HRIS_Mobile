// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  final int userId;

  const SettingsPage({super.key, required this.userId});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController employeeNoController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController createdAtController = TextEditingController();

  File? _image;
  String profileUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final res = await http.get(Uri.parse('http://192.168.99.139:3000/api/users/${widget.userId}'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      final createdAtRaw = data['created_at'];
      final dateTime = DateTime.tryParse(createdAtRaw);
      final formattedDate = dateTime != null
          ? DateFormat('yyyy-MM-dd, HH:mm').format(dateTime)
          : createdAtRaw;

      setState(() {
        fNameController.text = data['f_name'];
        lNameController.text = data['l_name'];
        emailController.text = data['email'];
        usernameController.text = data['username'];
        employeeNoController.text = data['employee_number'];
        roleController.text = data['role'];
        createdAtController.text = formattedDate;
        profileUrl = 'http://192.168.99.139:3000/uploads/${data['p_pic']}';
      });
    }
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> updateProfile() async {
    var uri = Uri.parse('http://192.168.99.139:3000/${widget.userId}');
    var request = http.MultipartRequest('PUT', uri);

    request.fields['f_name'] = fNameController.text;
    request.fields['l_name'] = lNameController.text;

    if (_image != null) {
      request.files.add(await http.MultipartFile.fromPath('p_pic', _image!.path));
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
      fetchUserData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Update failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (profileUrl.isNotEmpty
                              ? NetworkImage(profileUrl)
                              : const AssetImage('')) as ImageProvider,
                    ),
                    InkWell(
                      onTap: pickImage,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color.fromRGBO(163, 29, 29, 1),
                        child: Icon(Icons.edit, size: 16, color: Color.fromRGBO(254, 249, 225, 1)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              buildRoundedTextField(controller: fNameController, label: 'First Name'),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: lNameController, label: 'Last Name'),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: emailController, label: 'Email', enabled: false),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: usernameController, label: 'Username', enabled: false),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: employeeNoController, label: 'Employee Number', enabled: false),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: roleController, label: 'Role', enabled: false),
              const SizedBox(height: 10),
              buildRoundedTextField(controller: createdAtController, label: 'Created At', enabled: false),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
                  foregroundColor: const Color.fromRGBO(254, 249, 225, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: updateProfile,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('Save Changes'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRoundedTextField({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
  }) {
    const fieldTextStyle = TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black87,
    );

    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: !enabled,
      style: fieldTextStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: fieldTextStyle,
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
