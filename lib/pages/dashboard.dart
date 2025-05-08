import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hris_mobile/components/sidebar.dart';
import 'package:logger/logger.dart';
import 'leave_form.dart';
import './settings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSidebarExpanded = false;
  int activeNavIndex = 0;
  String? firstName;
  String? profilePic;

  final Logger _logger = Logger();

  Future<void> fetchUserData(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.99.139:3000/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
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

  void toggleSidebar() {
    setState(() {
      isSidebarExpanded = !isSidebarExpanded;
    });
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
      case 7:
        return const LeaveForm();
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
            IconButton(
              icon: Icon(
                isSidebarExpanded ? Icons.menu_open : Icons.menu,
                color: const Color.fromRGBO(254, 249, 225, 1),
              ),
              onPressed: toggleSidebar,
            ),
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
                'H.R.I.S.',
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
            child: GestureDetector(
              onTap: () {
              },
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
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Sidebar(
                  isExpanded: false,
                  activeIndex: activeNavIndex,
                  onNavItemSelect: handleNavItemSelect,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: _buildContent(),
                ),
              ),
            ],
          ),

          if (isSidebarExpanded)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 300,
              child: Sidebar(
                isExpanded: true,
                activeIndex: activeNavIndex,
                onNavItemSelect: handleNavItemSelect,
              ),
            ),
        ],
      ),
    );
  }
}
