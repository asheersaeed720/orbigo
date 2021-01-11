import 'package:flutter/material.dart';

// TEXTFIELD
InputDecoration buildTextFieldInputDecoration(labelText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    labelText: labelText,
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

// PASSWORD FIELD
InputDecoration buildPasswordInputDecoration(
    String labelText, IconData icon, suffixIcon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    suffixIcon: suffixIcon,
    // hintText: hintText,
    labelText: labelText,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
