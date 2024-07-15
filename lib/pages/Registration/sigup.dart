// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkzapp/Firebase/firebase_operations.dart';
import 'package:talkzapp/Themes/ThemeNotifier.dart';

import '../home.dart';

class Signup extends StatefulWidget {
  final void Function() onTap;
  const Signup({super.key, required this.onTap});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();

  FirebaseOperations firebaseOperations = FirebaseOperations();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passController.dispose();
    repassController.dispose();
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
                      const Color(0xFF121212),
                      const Color(0xFF1F1F1F),
                      const Color(0xFF303030),
                    ]
                  : [
                      const Color(0xFFE0FAE3),
                      const Color(0xFFB2F2D0),
                      const Color(0xFF80EA99),
                    ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 24.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ModernTextField(
                                    label: "First name",
                                    textEditingController: firstNameController,
                                    keyboardType: TextInputType.name,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: ModernTextField(
                                  label: "Last name",
                                  textEditingController: lastNameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ModernTextField(
                            label: "Email",
                            textEditingController: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ModernTextField(
                            label: "Username",
                            textEditingController: usernameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          PasswordTextField(
                            label: "Password",
                            textEditingController: passController,
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          PasswordTextField(
                            label: "Confirm Password",
                            textEditingController: repassController,
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          CreateAccountButton(themeNotifier),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Separator(themeNotifier),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularImageButton(
                                imageUrl: 'assets/images/google.png',
                                onPressed: () {},
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              CircularImageButton(
                                imageUrl: 'assets/images/facebook.png',
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: themeNotifier
                                    .currentTheme.textTheme.bodySmall,
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  'Login',
                                  style: themeNotifier
                                      .currentTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                themeNotifier.toggleTheme();
                              },
                              child: const Text('theme'))
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
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(
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
          String firstName = firstNameController.text.trim();
          String lastName = lastNameController.text.trim();
          String email = emailController.text.trim();
          String username = usernameController.text.trim();
          String password = passController.text.trim();
          String response = await firebaseOperations.emailAndPassUser(
            email: email,
            password: password,
            username: username,
            firstName: firstName,
            lastName: lastName,
          );
          showThemedSnackbar(context, response);
          Timer(const Duration(seconds: 6), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            child: Text(
              'Create Account',
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

  Row Separator(ThemeNotifier themeNotifier) {
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
          'Or Sign up with',
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

class ModernTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const ModernTextField({
    super.key,
    required this.label,
    required this.textEditingController,
    required this.keyboardType,
    required this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    return TextField(
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      style: themeNotifier.currentTheme.textTheme.bodySmall,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: themeNotifier.currentTheme.textTheme.bodySmall?.copyWith(
          color: themeNotifier.currentTheme.colorScheme.primary,
        ),
        filled: true,
        fillColor: themeNotifier.currentTheme.colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: themeNotifier.currentTheme.colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: themeNotifier.currentTheme.colorScheme.primary,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const PasswordTextField({
    super.key,
    required this.label,
    required this.textEditingController,
    required this.keyboardType,
    required this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    bool isVisible = true;
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    return StatefulBuilder(
      builder: (context, setState) => TextField(
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        obscureText: isVisible,
        style: themeNotifier.currentTheme.textTheme.bodySmall,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          labelText: label,
          labelStyle: themeNotifier.currentTheme.textTheme.bodySmall?.copyWith(
            color: themeNotifier.currentTheme.colorScheme.primary,
          ),
          filled: true,
          fillColor: themeNotifier.currentTheme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: themeNotifier.currentTheme.colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: themeNotifier.currentTheme.colorScheme.primary,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
}

class CircularImageButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;

  const CircularImageButton({
    super.key,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
