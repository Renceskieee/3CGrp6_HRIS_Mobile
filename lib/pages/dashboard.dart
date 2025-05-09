import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hris_mobile/components/navbar.dart';
import 'package:logger/logger.dart';
import './settings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int activeNavIndex = 0;
  String? firstName;
  String? profilePic;

  final Logger _logger = Logger();

  Future<void> fetchUserData(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.99.139:3000/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        firstName = data['user']['f_name'];
        profilePic = 'http://192.168.99.139:3000/uploads/${data['user']['p_pic']}';
      });
      _logger.i('Login successful: ${data['user']}');
    } else {
      _logger.e('Login failed: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData('Rency', 'Laurence027');
  }

  void handleNavItemSelect(int index) {
    setState(() {
      activeNavIndex = index;
    });
  }

  Widget _buildContent() {
    switch (activeNavIndex) {
      case 3:
        return const SettingsPage(userId: 4);
      default:
        return const Center(
          child: Text(
            'Coming Soon...',
            style: TextStyle(fontSize: 24),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(109, 35, 35, 1),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/EARIST_Logo.png',
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'EARIST HRIS',
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(254, 249, 225, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromRGBO(254, 249, 225, 1),
              child: profilePic != null
                  ? ClipOval(
                      child: Image.network(
                        profilePic!,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      firstName != null ? firstName![0] : '',
                      style: const TextStyle(fontSize: 24),
                    ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
            ),
          ),
          Sidebar(
            activeIndex: activeNavIndex,
            onNavItemSelect: handleNavItemSelect,
          ),
        ],
      ),
    );
  }
}
