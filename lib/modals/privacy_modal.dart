import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyModal extends StatelessWidget {
  const PrivacyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Privacy Policy", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Text(
          "We value your privacy. All personal information is secured and used solely for HRIS operations.",
          style: GoogleFonts.poppins(),
        ),
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
