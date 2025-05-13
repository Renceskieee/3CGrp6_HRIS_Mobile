import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
    ),
  );
}
