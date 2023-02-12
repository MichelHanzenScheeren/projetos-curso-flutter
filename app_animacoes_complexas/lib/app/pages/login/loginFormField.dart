import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class LoginFormField extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureTextControl;
  final Function(String text) validator;

  LoginFormField({
    @required this.text,
    @required this.icon,
    this.controller,
    this.obscureTextControl: false,
    this.validator,
  });

  @override
  _LoginFormFieldState createState() =>
      _LoginFormFieldState(obscureTextControl);
}

class _LoginFormFieldState extends State<LoginFormField> {
  final obscureTextControl;
  bool obscure;
  bool autoValidate;
  _LoginFormFieldState(this.obscureTextControl) {
    obscure = obscureTextControl;
    autoValidate = false;
  }

  void setObscureValue() {
    if (obscure)
      setState(() => obscure = false);
    else
      setState(() => obscure = true);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      enableInteractiveSelection: obscureTextControl ? false : true,
      validator: widget.validator,
      controller: widget.controller,
      autovalidate: autoValidate,
      onChanged: (_) => setState(() => autoValidate = true),
      keyboardType: obscureTextControl && !obscure
          ? TextInputType.visiblePassword
          : TextInputType.text,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        errorMaxLines: 2,
        prefixIcon: Icon(widget.icon, color: Colors.grey),
        hintText: widget.text,
        suffixIcon: obscureTextControl
            ? IconButton(
                icon: obscure
                    ? Icon(Icons.visibility_off, color: Colors.grey)
                    : Icon(Icons.visibility, color: Colors.white70),
                onPressed: setObscureValue,
              )
            : null,
      ),
      style: myInputTextStyle(),
    );
  }
}
