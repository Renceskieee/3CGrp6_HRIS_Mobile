import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordModal extends StatelessWidget {
  const ForgotPasswordModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Forgot Password',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Please contact your system administrator to reset your password.',
        style: GoogleFonts.poppins(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(163, 29, 29, 1),
            ),
          ),
        ),
      ],
    );
  }
}
