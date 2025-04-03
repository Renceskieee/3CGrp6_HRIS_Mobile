import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutModal extends StatelessWidget {
  const AboutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("About", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      content: Text(
        "EARIST Human Resource Information System is designed to efficiently manage faculty and staff records.",
        style: GoogleFonts.poppins(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close", style: GoogleFonts.poppins(color: const Color.fromRGBO(163, 29, 29, 1))),
        ),
      ],
    );
  }
}
