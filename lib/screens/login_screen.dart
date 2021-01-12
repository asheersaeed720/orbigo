import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbigo/models/user.dart';
import 'package:orbigo/screens/user/user_screen.dart';
import 'package:orbigo/utils/input_decoration.dart';
import 'package:orbigo/utils/long_btn.dart';

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
    final usernameField = TextFormField(
      // validator: (value) => value.isEmpty ? "Please type username" : null,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _userCredential.username = value,
      decoration: buildTextFieldInputDecoration(
          "Username", Icons.account_circle_rounded),
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      // validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) {
        setState(() {
          _userCredential.password = value;
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
    );

    final serverPortField = TextFormField(
      // validator: (value) => value.isEmpty ? "Please type server address" : null,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) => _userCredential.serverAddress = value,
      decoration:
          buildTextFieldInputDecoration("Server Address", Icons.wb_cloudy),
    );

    var doLogin = () {
      Navigator.of(context).pushNamed(UserScreen.routeName);
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        // authPvd.login(context, _userCredential);
      }
    };

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      './assets/images/logo.png',
                      width: 200,
                    ),
                    const SizedBox(height: 42.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: usernameField,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: passwordField,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: serverPortField,
                    ),
                    // authPvd.isLoading
                    //     ? LoadingIndicator()
                    //     : longButton(context, 'login', doLogin),
                    const SizedBox(height: 20.0),
                    longButton(context, 'LOGIN', doLogin),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
