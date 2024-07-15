import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/country_code_picker.dart';
import '../Themes/ThemeNotifier.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String selectedCountryCode = '+92';
  TextEditingController phoneNumberController = TextEditingController();
  bool generatingOTP = false;

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeNotifier = Provider.of<ThemeNotifier>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  topHead(themeNotifier),
                  Info(themeNotifier: themeNotifier),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1.0,
                            color: themeNotifier.currentTheme.primaryColor,
                          ),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountryCode = newValue!;
                            });
                          },
                          items: CountryCodePicker.countries
                              .map<DropdownMenuItem<String>>(
                            (Map<String, String> country) {
                              return DropdownMenuItem<String>(
                                value: country['code']!,
                                child: Text('${country['name']}'),
                              );
                            },
                          ).toList(),
                          style: themeNotifier.currentTheme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 80.0,
                      right: 80.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: themeNotifier.currentTheme.primaryColor,
                              ),
                            ),
                          ),
                          child: Text(
                            selectedCountryCode,
                            style:
                                themeNotifier.currentTheme.textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color:
                                      themeNotifier.currentTheme.primaryColor,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              style: themeNotifier
                                  .currentTheme.textTheme.bodySmall,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  bottom: -10.0,
                                ),
                                hintText: 'Enter your phone number',
                                hintStyle: themeNotifier
                                    .currentTheme.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        style: themeNotifier
                            .currentTheme.elevatedButtonTheme.style,
                        onPressed: () {
                          sendOtp(
                            context,
                            themeNotifier,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: generatingOTP
                                ? const SizedBox(
                                    key: ValueKey('progress'),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : Text(
                                    'Next',
                                    key: const ValueKey('next'),
                                    style: themeNotifier
                                        .currentTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      letterSpacing: 2.0,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding topHead(ThemeNotifier themeNotifier) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30.0,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 30.0,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Verify your phone number',
                style: themeNotifier.currentTheme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.green.shade800),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                themeNotifier.toggleTheme();
              },
              icon: const Icon(
                Icons.more_vert,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemedDialog(
      BuildContext context, String message, ThemeNotifier themeNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: themeNotifier.currentTheme.colorScheme.onPrimary,
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: themeNotifier.currentTheme.colorScheme.error,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Error',
                      style: themeNotifier.currentTheme.textTheme.bodyMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeNotifier.currentTheme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
            ],
          ),
          content: Text(
            message,
            style: themeNotifier.currentTheme.textTheme.bodySmall?.copyWith(
              color: themeNotifier.currentTheme.colorScheme.error,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: themeNotifier.currentTheme.textTheme.bodySmall?.copyWith(
                  color: themeNotifier.currentTheme.colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void sendOtp(BuildContext context, ThemeNotifier themeNotifier) {
    FocusScope.of(context).unfocus();
    showThemedDialog(
      context,
      "error",
      themeNotifier,
    );
    // setState(() {
    //   generatingOTP = !generatingOTP;
    // });
    // FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneNumberController.text,
    //   verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
    //   verificationFailed: (FirebaseException error) {
    //     log(error.toString());
    //     showThemedDialog(
    //       context,
    //       error.toString(),
    //       themeNotifier,
    //     );
    //     setState(() {
    //       generatingOTP = !generatingOTP;
    //     });
    //   },
    //   codeSent: (verificationId, forceResendingCode) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => OTPPage(verificationId: verificationId),
    //       ),
    //     );
    //   },
    //   codeAutoRetrievalTimeout: (verificationId) {
    //     log('Auto retrieval timeout');
    //   },
    // );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.themeNotifier,
  });

  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 35.0,
          right: 30.0,
          top: 20.0,
        ),
        child: Text(
          'TalkzApp will send an SMS message (carrier charges may apply) to verify your phone number. \n Enter your country code and phone number:',
          style: themeNotifier.currentTheme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
