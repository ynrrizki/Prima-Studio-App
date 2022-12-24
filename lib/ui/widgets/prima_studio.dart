import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaStudio extends StatelessWidget {
  const PrimaStudio({
    Key? key,
    this.fontSize,
  }) : super(key: key);
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'PRIMA',
          style: GoogleFonts.plusJakartaSans(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'STUDIO',
          style: GoogleFonts.plusJakartaSans(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
