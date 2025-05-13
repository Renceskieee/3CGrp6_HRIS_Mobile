import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris_mobile/components/navbar.dart';
import './settings.dart';
import 'package:hris_mobile/components/snackbar.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int activeNavIndex = 0;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomSnackBar(context, 'Welcome, ${user['f_name']} ${user['l_name']}');
    });
  }

  void handleNavItemSelect(int index) {
    setState(() {
      activeNavIndex = index;
    });
  }

  void refreshUserProfile(Map<String, dynamic> updatedUser) {
    setState(() {
      user = updatedUser;
    });
  }

  Widget _buildContent() {
    switch (activeNavIndex) {
      case 3:
        return SettingsPage(
          user: user,
          onProfileUpdated: refreshUserProfile,
        );
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
    final profilePic = user['p_pic'] != null
        ? 'http://192.168.99.139:3000/uploads/${user['p_pic']}'
        : null;

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
                        profilePic,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      user['f_name']?[0] ?? '',
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
