import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON parsing
import 'package:hris_mobile/components/sidebar.dart';
import 'package:logger/logger.dart';  // Import the logger package

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

  // Logger instance
  final Logger _logger = Logger();

  // Method to fetch user data after login
  Future<void> fetchUserData(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/login'), // Adjust URL as per your server
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final data = json.decode(response.body);
      setState(() {
        firstName = data['user']['f_name']; // User's first name
        profilePic = data['user']['p_pic']; // Profile picture (URL or path)
      });
      _logger.i('Login successful: ${data['user']}');
    } else {
      // Handle login failure
      _logger.e('Login failed: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    // Replace with valid credentials or implement a login form to get user input
    fetchUserData('hanapot', '145116');
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
            const Spacer(),  // This will push the profile section to the far right
            // Profile picture or initials on the right side
            GestureDetector(
              onTap: () {
                // Handle tap (for profile settings, logout, etc.)
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: profilePic != null
                    ? ClipOval(
                        child: Image.network(
                          profilePic!,  // Use the profile image URL from the API
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text(
                        firstName != null ? firstName![0] : '', // Use first letter of name if no image
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: Stack(
        children: [
          Sidebar(
            isExpanded: isSidebarExpanded,
            activeIndex: activeNavIndex,
            onNavItemSelect: handleNavItemSelect,
          ),
          Positioned.fill(
            left: isSidebarExpanded ? 200.0 : 80.0,
            child: Column(
              children: const [
                Expanded(
                  child: Center(
                    child: SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
