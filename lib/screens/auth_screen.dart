// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shoepal/models/http_exception.dart';
import 'package:shoepal/providers/auth.dart';
import 'package:shoepal/shared/colors.dart';
import 'package:shoepal/shared/styles.dart';
import 'package:shoepal/widget/button.dart';

enum AuthMode { Login, Signup }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SizedBox(
          height: deviceSize.height,
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(top: 120),
                width: deviceSize.width,
                height: deviceSize.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  color: customBlack,
                ),
                child: Text(
                  'ShoePal',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: customPrimary),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: AuthCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Error Found',
          style: Theme.of(context).textTheme.headline3,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Okay',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      // form is invalid
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(
          context,
          listen: false,
        ).signIn(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(
          context,
          listen: false,
        ).signUp(_authData['email'], _authData['password']);
      }
    } on HttpException catch (err) {
      var errorMessage = 'Authentication Failed';
      if (err.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email has already taken';
      }
      if (err.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      }
      if (err.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      }
      if (err.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Cannot find user with that email';
      }
      if (err.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid credentials';
      }
      _showErrorDialog(errorMessage);
    } catch (err) {
      const errorMessage = 'Cannot log you in. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: AnimatedContainer(
        width: deviceSize.width * 0.85,
        // height: _heightAnimation.value.height,
        height: _authMode == AuthMode.Signup ? 340 : 280,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: giveInputStyle('Email'),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['email'] = val;
                  },
                ),
                TextFormField(
                  decoration: giveInputStyle('Password'),
                  obscureText: true,
                  controller: _passwordController,
                  style: Theme.of(context).textTheme.bodyText1,
                  validator: (val) {
                    if (val.isEmpty || val.length < 8) {
                      return 'Minimum password length is 8';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authData['password'] = val;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: giveInputStyle('Confirm Password'),
                        obscureText: true,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: _authMode == AuthMode.Signup
                            ? (val) {
                                if (val != _passwordController.text) {
                                  return 'Password do not match';
                                }
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        title:
                            _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                        onPressed: _onSubmit,
                        isLoading: _isLoading,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _authMode == AuthMode.Login
                          ? 'Don\'t have an account?'
                          : 'Already have account?',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    FlatButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        _authMode == AuthMode.Login ? 'Signup' : 'Login',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
