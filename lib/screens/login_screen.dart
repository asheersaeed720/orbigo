import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/screens/user_screens/user_screen.dart';
import 'package:orbigo/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();

  UserCredential _userCredential = UserCredential();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: _formWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget() {
    var doLogin = () {
      Navigator.of(context).pushNamed(UserScreen.routeName);
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        // authPvd.login(context, _userCredential);
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
          _usernameWidget(),
          const SizedBox(height: 20.0),
          _passwordWidget(),
          const SizedBox(height: 20.0),
          _channelNameWidget(),
          const SizedBox(height: 20.0),
          longButton(context, 'login', doLogin),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _usernameWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        // validator: (value) => value.isEmpty ? "Please type username" : null,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _userCredential.username = value.trim(),
        decoration: buildTextFieldInputDecoration(
            "Username", Icons.account_circle_rounded),
      ),
    );
  }

  Widget _passwordWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        obscureText: _obscureText,
        // validator: (value) => value.isEmpty ? "Please enter password" : null,
        onSaved: (value) {
          setState(() {
            _userCredential.password = value.trim();
          });
        },
        onChanged: (text) {
          _userCredential.password = text;
        },
        decoration: buildPasswordInputDecoration(
          "Password",
          Icons.lock,
          GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: new Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }

  Widget _channelNameWidget() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        // validator: (value) => value.isEmpty ? "Please type server address" : null,
        keyboardType: TextInputType.streetAddress,
        onSaved: (value) => _userCredential.serverAddress = value.trim(),
        decoration:
            buildTextFieldInputDecoration("Server Address", Icons.wb_cloudy),
      ),
    );
  }
}
