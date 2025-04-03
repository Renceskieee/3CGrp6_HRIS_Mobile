import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactModal extends StatelessWidget {
  const ContactModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        "Contact",
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/mail.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 8),
              Text("Email:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text("quiniano.lp.bsinfotech@gmail.com", style: GoogleFonts.poppins()),
          ),
          SizedBox(height: 12),

          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/phone.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(width: 8),
              Text("Phone:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Text("0915 612 8497", style: GoogleFonts.poppins()),
          ),
        ],
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
