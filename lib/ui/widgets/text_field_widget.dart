import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  final Text? label;

  bool? obscureText;

  final bool? autofocus;

  final String? Function(String? value)? validator;

  final TextEditingController? controller;

  final String? initialValue;
  final Function(String)? onChanged;
  bool? readOnly;

  TextFieldWidget({
    super.key,
    this.controller,
    this.label,
    this.obscureText = false,
    this.autofocus = false,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText!,
      autofocus: widget.autofocus!,
      validator: widget.validator,
      initialValue: widget.initialValue,
      readOnly: widget.readOnly!,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        floatingLabelStyle: GoogleFonts.plusJakartaSans(
          color: Theme.of(context).primaryColor,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: widget.label!.data!.contains('Password')
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText!;
                  });
                },
                child: widget.obscureText ?? true
                    ? const Icon(Icons.visibility_off)
                    : Icon(Icons.visibility,
                        color: Theme.of(context).primaryColor),
              )
            : null,
        hoverColor: Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor,
        label: widget.label,
        iconColor: Theme.of(context).primaryColor,
      ),
      cursorColor: Theme.of(context).primaryColor,
    );
  }
}
