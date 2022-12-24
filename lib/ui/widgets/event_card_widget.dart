import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.all(27),
        // height: 190,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 228, 214, 184),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            RichText(
              // textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'SAINTEK FAIR\n',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: Colors.orange,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: '(SCIENCE ART AND TECHNOLOGY FAIR)\n\n',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      color: Colors.orange,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Pameran projek penguatan profil pelajar pancasila kearifan lokal & rekayasa teknologi\n',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 41, 41, 41),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
