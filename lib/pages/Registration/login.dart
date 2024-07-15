import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkzapp/Firebase/firebase_operations.dart';
import 'package:talkzapp/Themes/ThemeNotifier.dart';
import 'package:talkzapp/pages/Registration/sigup.dart';
import 'package:talkzapp/pages/home.dart';

class Signin extends StatefulWidget {
  final void Function() onTap;

  const Signin({super.key, required this.onTap});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FirebaseOperations firebaseOperations = FirebaseOperations();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeNotifier.isDarkMode
                  ? [
                      Color(0xFF121212),
                      Color(0xFF1F1F1F),
                      Color(0xFF303030),
                    ]
                  : [
                      Color(0xFFE0FAE3),
                      Color(0xFFB2F2D0),
                      Color(0xFF80EA99),
                    ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 24.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          ModernTextField(
                            label: "Email",
                            textEditingController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          PasswordTextField(
                            label: "Password",
                            textEditingController: passController,
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          CreateAccountButton(themeNotifier),
                          SizedBox(
                            height: 30.0,
                          ),
                          separator(themeNotifier),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularImageButton(
                                imageUrl: 'assets/images/google.png',
                                onPressed: () {},
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              CircularImageButton(
                                imageUrl: 'assets/images/facebook.png',
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don\'t have an account?",
                                style: themeNotifier
                                    .currentTheme.textTheme.bodySmall,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  'Signup',
                                  style: themeNotifier
                                      .currentTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showThemedSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(
        seconds: 6,
      ),
      backgroundColor: Colors.blue,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        textColor: Colors.yellow,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Center CreateAccountButton(ThemeNotifier themeNotifier) {
    return Center(
      child: ElevatedButton(
        style: themeNotifier.currentTheme.elevatedButtonTheme.style,
        onPressed: () async {
          FocusScope.of(context).unfocus();
          String email = emailController.text.trim();
          String password = passController.text.trim();
          UserCredential response = await firebaseOperations.signIn(
            password: password,
            email: email,
          );
          if (response.user != null) {
            showThemedSnackbar(
                context, "Logged in with ${response.user?.email} successfully");
            Timer(Duration(seconds: 6), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            });
          } else {
            showThemedSnackbar(context, "${response}");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            child: Text(
              'Sign in',
              style: themeNotifier.currentTheme.textTheme.bodySmall?.copyWith(
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row separator(ThemeNotifier themeNotifier) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Divider(
              color: themeNotifier.currentTheme.colorScheme.onSurface,
            ),
          ),
        ),
        Text(
          'Or Log in with',
          style: themeNotifier.currentTheme.textTheme.bodySmall,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Divider(
              color: themeNotifier.currentTheme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
