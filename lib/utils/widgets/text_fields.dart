// ignore_for_file: camel_case_types, must_be_immutable

import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';

class kFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? readOnly;
  int? maxLines;
  List<String>? autofillHints;
  kFormField({super.key, required this.hintText, required this.controller, this.validator, this.suffixIcon, this.prefixIcon, this.maxLines ,this.readOnly=false, this.autofillHints});

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
      readOnly: readOnly!,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      autofillHints: autofillHints,
    );
  }
}

class kDropDownFormField<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?) callBack;
  final String? Function(T?)? validator;

  
  const kDropDownFormField({super.key, required this.items, this.validator, required this.value, required this.callBack});

  @override
  State<kDropDownFormField<T>> createState() => _kDropDownFormFieldState<T>();
}

class _kDropDownFormFieldState<T> extends State<kDropDownFormField<T>> {
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
            color: error400,
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(
            color: error400
          )
        ),
      ),
      items: widget.items, 
      validator: widget.validator,
      onChanged: widget.callBack,
      value: widget.value,
    );
  }
}


class OTPFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool hasError;
  bool hasFocus;
  OTPFormField({super.key, required this.controller, required this.hasError, this.hasFocus = false});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 48,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: hasError? const Color(0xFFF44336) : const Color(0xFFCECECE)
        )
      ),
      child: TextField(
        decoration: InputDecoration(
          counterText: '',
          focusedBorder:  UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.42,
              color: hasError? const Color(0xFFF44336) : const Color(0xFFCECECE)
            )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.42,
              color: hasError? const Color(0xFFF44336) : const Color(0xFFCECECE)
            )
          ),
        ),
        controller: controller,
        textAlign: TextAlign.center,
        autofocus: hasFocus,
        keyboardType: TextInputType.number,
        showCursor: true,
        maxLength: 1,
        onChanged: (value){
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}