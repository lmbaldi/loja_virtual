import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  String label;
  String hint;
  bool password;
  bool autoCorrect;
  bool enabled;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppTextInput(
      this.label,
      this.hint, {
        this.password = false,
        this.controller,
        this.validator,
        this.keyboardType,
        this.textInputAction,
        this.focusNode,
        this.nextFocus,
        this.autoCorrect = false,
        this.enabled,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: autoCorrect,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      enabled: enabled,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
