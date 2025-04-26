import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: GoogleFonts.poppins()),
        backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
      ),
      body: Center(
        child: Text(
          'Welcome to Dashboard!',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
      ),
    );
  }
}