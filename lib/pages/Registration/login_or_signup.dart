import 'package:flutter/material.dart';
import 'package:talkzapp/pages/Registration/login.dart';
import 'package:talkzapp/pages/Registration/sigup.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool signin = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: child.key == const ValueKey<bool>(true)
              ? const Offset(1.0, 0.0)
              : const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: signin
          ? Signin(key: const ValueKey<bool>(true), onTap: togglePage)
          : Signup(key: const ValueKey<bool>(false), onTap: togglePage),
    );
  }

  void togglePage() {
    setState(() {
      signin = !signin;
    });
  }
}
