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

Container longButton(context, String title, Function function) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: function,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ),
    ),
  );
}
