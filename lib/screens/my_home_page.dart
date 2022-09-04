import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shops_app/widgets/adaptive_button.dart';

import '../constants.dart';
import '../widgets/side_drawer.dart';
import '../enum/authentication_type.dart';
import '../utils/text_validators.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthenticationType _authenticationType = AuthenticationType.SIGN_IN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Platform.isIOS ? Icons.add : Icons.settings),
          )
        ],
      ),
      floatingActionButton: Platform.isIOS
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
            ),
      drawer: Drawer(
        child: SideDrawer(),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: ValueKey(Constants.KEY_EMAIL),
                validator: (value) {
                  if (!value.isEmailValid()) {
                    return Constants.ERROR_EMAIL;
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              TextFormField(
                key: ValueKey(Constants.KEY_PASSWORD),
                validator: (value) {
                  if (value.length < 4) {
                    return Constants.ERROR_PASSWORD;
                  }
                  return null;
                },
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              if (_authenticationType == AuthenticationType.SIGN_UP)
                TextFormField(
                  key: ValueKey(Constants.KEY_CONFIRM_PASSWORD),
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (_authenticationType == AuthenticationType.SIGN_IN) {
                      return null;
                    }
                    if (value.length < 4) {
                      return Constants.ERROR_PASSWORD;
                    } else if (_passwordController.text.toString() !=
                        _confirmPasswordController.text.toString()) {
                      return Constants.ERROR_PASSWORD_MATCHING;
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _authenticationType == AuthenticationType.SIGN_UP
                      ? AdaptiveButton(ValueKey(Constants.KEY_SIGNUP_BUTTON),
                          Constants.SIGN_UP_BUTTON_TEXT, _changeBody)
                      : FlatButton(
                          color: Colors.green,
                          key: ValueKey(Constants.KEY_LOGIN_BUTTON),
                          padding: const EdgeInsets.all(10),
                          child: Text(Constants.LOGIN_BUTTON_TEXT),
                          onPressed: _changeBody,
                        ),
                ],
              ),
              GestureDetector(
                onTap: () => _changeView(
                    _authenticationType == AuthenticationType.SIGN_IN
                        ? AuthenticationType.SIGN_UP
                        : AuthenticationType.SIGN_IN),
                child: _authenticationType == AuthenticationType.SIGN_IN
                    ? Text(
                        Constants.CREATE_ACCOUNT_TEXT,
                        key: ValueKey(Constants.CREATE_ACCOUNT_KEY),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.blue),
                      )
                    : Text(
                        Constants.ALREADT_HAVE_AN_ACCOUNT_TEXT,
                        key: ValueKey(Constants.CREATE_ACCOUNT_KEY),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.blue),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeView(AuthenticationType authenticationType) {
    setState(() {
      _authenticationType = authenticationType;
    });
  }

  void _changeBody() {
    _formKey.currentState.validate();
  }
}
