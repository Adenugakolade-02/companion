// ignore_for_file: camel_case_types, must_be_immutable

import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';

class kFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  Widget? suffixIcon;
  Widget? prefixIcon;
  kFormField({super.key, required this.hintText, required this.controller, this.validator, this.suffixIcon, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            color: grey400,
          )
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            color: grey400,
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            color: error400
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            color: error400,
          )
        ),
        
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon
      ),
    );
  }
}