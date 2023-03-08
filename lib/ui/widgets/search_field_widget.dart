import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    Key? key,
    required this.searchController,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      autofocus: false,
      style: GoogleFonts.plusJakartaSans(
        color: Colors.black,
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        hintText: 'Search for film',
        filled: true,
        fillColor: Colors.grey.shade100,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.grey,
        ),
      ),
    );
  }
}
