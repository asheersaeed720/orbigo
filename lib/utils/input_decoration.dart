import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(labelText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    labelText: labelText,
    contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}

// PASSWORD FIELD
InputDecoration buildPasswordInputDecoration(
    String labelText, IconData icon, suffixIcon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    suffixIcon: suffixIcon,
    labelText: labelText,
    contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: Colors.red),
    ),
  );
}

// TEXTFIELD
// InputDecoration buildTextFieldInputDecoration(labelText, IconData icon) {
//   return InputDecoration(
//     prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
//     // hintText: hintText,
//     labelText: labelText,
//     hintStyle: TextStyle(color: Colors.grey),
//     contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
//   );
// }
