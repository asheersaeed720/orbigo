import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/providers/auth_provider.dart';
import 'package:orbigo/screens/user_screens/user_screen.dart';
import 'package:orbigo/utils/constants.dart';
import 'package:orbigo/widgets/loading_indicator.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = '/login';

  final _formKey = new GlobalKey<FormState>();

  UserCredential _userCredential = UserCredential();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authPvd = watch(authProvider);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: _formWidget(context, authPvd),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget(context, AuthProvider authPvd) {
    var doLogin = () {
      if (_formKey.currentState.validate()) {
        print(_userCredential.usernameOrEmail);
        authPvd.login(context, _userCredential);
      }
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset(
            './assets/images/logo.png',
            width: 200,
          ),
          const SizedBox(height: 42.0),
          _usernameOrEmailWidget(context),
          const SizedBox(height: 20.0),
          _passwordWidget(context),
          const SizedBox(height: 20.0),
          authPvd.isLoading
              ? LoadingIndicator()
              : longButton(context, 'LOGIN', doLogin),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _usernameOrEmailWidget(context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        validator: (value) => value.isEmpty ? "Please type username" : null,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _userCredential.usernameOrEmail = value.trim(),
        onChanged: (text) => _userCredential.usernameOrEmail = text,
        decoration: buildTextFieldInputDecoration(
            "UsernameOrEmail", Icons.account_circle_rounded),
      ),
    );
  }

  Widget _passwordWidget(context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        obscureText: _obscureText,
        validator: (value) => value.isEmpty ? "Please enter password" : null,
        onSaved: (value) => _userCredential.password = value.trim(),
        onChanged: (text) => _userCredential.password = text,
        decoration: buildPasswordInputDecoration(
          "Password",
          Icons.lock,
          GestureDetector(
            onTap: () {
              _obscureText = !_obscureText;
            },
            child: new Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
