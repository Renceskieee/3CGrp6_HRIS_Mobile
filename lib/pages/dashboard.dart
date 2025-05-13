// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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

  Widget _buildDashboardIcons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 360, // Increase height for 2 cards per row layout
        child: GridView.count(
          crossAxisCount: 2, // Changed from 4 to 2
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildIconCard(
              iconPath: 'assets/icons/attendance.svg',
              label: 'Attendance',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attendance clicked')),
                );
              },
            ),
            _buildIconCard(
              iconPath: 'assets/icons/forms.svg',
              label: 'Forms',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Forms clicked')),
                );
              },
            ),
            _buildIconCard(
              iconPath: 'assets/icons/payroll.svg',
              label: 'Payroll',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payroll clicked')),
                );
              },
            ),
            _buildIconCard(
              iconPath: 'assets/icons/request.svg',
              label: 'Request',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request clicked')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(229, 208, 172, 1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 36,
              height: 36,
              color: const Color.fromRGBO(109, 35, 35, 1),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(109, 35, 35, 1),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (activeNavIndex) {
      case 0:
        return _buildDashboardIcons();
      case 3:
        return SettingsPage(
          user: user,
          onProfileUpdated: refreshUserProfile,
        );
      default:
        return const Center(
          child: Text(
            'No content available.',
            style: TextStyle(fontSize: 24),
          ),
        );
    }
  }

  Widget _buildDateTimeContainer() {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    final date = DateFormat('MMMM dd, yyyy').format(now);

    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(254, 249, 225, 1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 20,
                height: 20,
                color: const Color.fromRGBO(109, 35, 35, 1),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(109, 35, 35, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar2.svg',
                width: 20,
                height: 20,
                color: const Color.fromRGBO(109, 35, 35, 1),
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: GoogleFonts.poppins(
                  color: const Color.fromRGBO(109, 35, 35, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
          if (activeNavIndex == 0) _buildDateTimeContainer(),
          Expanded(
            child: Container(
              color: Colors.white,
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
