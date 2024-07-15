import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkzapp/pages/home.dart';

import '../Themes/ThemeNotifier.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        backgroundColor: themeNotifier.currentTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to ${widget.verificationId}',
              textAlign: TextAlign.center,
              style: themeNotifier.currentTheme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 200.0,
              child: TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: '123456',
                  counterText: '',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: themeNotifier.currentTheme.primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                style: themeNotifier.currentTheme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String enteredOTP = otpController.text.trim();
                if (enteredOTP.length == 6) {
                  verifyOTP(enteredOTP);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid OTP'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeNotifier.currentTheme.primaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 16.0),
              ),
              child: Text(
                'Confirm',
                style: themeNotifier.currentTheme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP(String enteredOTP) async {
    try {
      final cred = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: enteredOTP);
      await FirebaseAuth.instance.signInWithCredential(cred).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
