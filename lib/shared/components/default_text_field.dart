// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? type;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function? onTap;
  final bool? readOnly;
  final bool? obsecure;
  final String? hintText;

  DefaultTextField({Key? key,
    required this.label,
    required this.controller,
    this.hintText,
    this.type,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.obsecure = false,
  }) : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.obsecure!,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: widget.readOnly!,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.type,
        decoration: InputDecoration(
        label: Text(widget.label),
        hintText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
        suffixIcon: widget.suffixIcon
      )
    );
  }
}
