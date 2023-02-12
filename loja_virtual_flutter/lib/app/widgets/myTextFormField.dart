import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String text;
  final bool obscure;
  final TextInputType type;
  final TextStyle style;
  final Function validator;
  final TextEditingController controller;
  MyTextFormField(
      {this.text: "",
      this.style,
      this.obscure: false,
      this.type: TextInputType.text,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscure,
      keyboardType: type,
      style: style.copyWith(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey[600]),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey[100]),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
