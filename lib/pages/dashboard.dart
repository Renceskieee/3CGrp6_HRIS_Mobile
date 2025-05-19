// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:hris_mobile/components/navbar.dart';
import './notifications.dart';
import './settings.dart';
import 'package:hris_mobile/components/snackbar.dart';
import 'request.dart';
import './change_password.dart';

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
      showCustomSnackBar(
        context,
        'Welcome, ${user['f_name']} ${user['l_name']}',
      );
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
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestScreen(user: user),
                    ),
                  );
                },
              ),
              _buildIconCard(
                iconPath: 'assets/icons/ellipsis.svg',
                label: 'More',
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('More clicked')));
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Image.asset(
                'assets/images/Cover.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildPromoCard(
                  iconPath: 'assets/icons/forms.svg',
                  label: 'Forms',
                  description: 'Submit and manage your forms easily.',
                  buttonText: 'Open',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Forms clicked')),
                    );
                  },
                ),
                _buildPromoCard(
                  iconPath: 'assets/icons/contacts.svg',
                  label: 'Contacts',
                  description: 'Find and connect with colleagues.',
                  buttonText: 'Browse',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Contacts clicked')),
                    );
                  },
                ),
                _buildPromoCard(
                  iconPath: 'assets/icons/password.svg',
                  label: 'Password',
                  description: 'Change your account password.',
                  buttonText: 'Change',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(user: user),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Organization clicked')),
                );
              },
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(109, 35, 35, 1),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              'assets/icons/organization.svg',
                              width: 32,
                              height: 32,
                              color: const Color.fromRGBO(109, 35, 35, 1),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Organization',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      Text(
                        'View your organization details.',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
            child: SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              color: const Color.fromRGBO(109, 35, 35, 1),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 9,
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
    );
  }

  Widget _buildPromoCard({
    required String iconPath,
    required String label,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(109, 35, 35, 1),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      iconPath,
                      width: 32,
                      height: 32,
                      color: const Color.fromRGBO(109, 35, 35, 1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (activeNavIndex) {
      case 0:
        return _buildDashboardIcons();
      case 1:
        return NotificationPage();
      case 3:
        return SettingsPage(user: user, onProfileUpdated: refreshUserProfile);
      default:
        return const Center(
          child: Text('No content available.', style: TextStyle(fontSize: 24)),
        );
    }
  }

  Widget _buildDateTimeContainer() {
    final now = DateTime.now();
    final time = DateFormat('hh:mm a').format(now);
    final date = DateFormat('MMMM dd, yyyy').format(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6D2323), Color(0xFF8A3B3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/clock.svg',
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                'assets/icons/calendar2.svg',
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white),
          const SizedBox(height: 8),
          _buildClockButtons(),
        ],
      ),
    );
  }

  Widget _buildClockButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Clock In clicked')));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            foregroundColor: const Color.fromRGBO(109, 35, 35, 1),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          icon: SvgPicture.asset(
            'assets/icons/clock-in.svg',
            width: 20,
            height: 20,
            color: const Color.fromRGBO(109, 35, 35, 1),
          ),
          label: Text(
            'Time In',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Clock Out clicked')));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            foregroundColor: const Color.fromRGBO(109, 35, 35, 1),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          icon: SvgPicture.asset(
            'assets/icons/clock-out.svg',
            width: 20,
            height: 20,
            color: const Color.fromRGBO(109, 35, 35, 1),
          ),
          label: Text(
            'Time Out',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profilePic =
        user['p_pic'] != null
            ? 'http://192.168.137.1:3000/uploads/${user['p_pic']}'
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
                  color: Colors.white,
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
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              child:
                  profilePic != null
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (activeNavIndex == 0) _buildDateTimeContainer(),
            _buildContent(),
          ],
        ),
      ),
      bottomNavigationBar: Sidebar(
        activeIndex: activeNavIndex,
        onNavItemSelect: handleNavItemSelect,
      ),
    );
  }
}
