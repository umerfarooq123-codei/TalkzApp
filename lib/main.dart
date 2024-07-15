import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:talkzapp/Firebase/firebase_operations.dart';
import 'package:talkzapp/Themes/ThemeNotifier.dart';
import 'package:talkzapp/firebase_options.dart';
import 'package:talkzapp/pages/Registration/login_or_signup.dart';
import 'package:talkzapp/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final themeNotifier = await ThemeNotifier.loadTheme();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => themeNotifier,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseOperations firebaseOperations = FirebaseOperations();
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: themeNotifier.isDarkMode
                ? const Color(0xFF121212)
                : const Color(0xFFE0FAE3),
            statusBarIconBrightness:
                themeNotifier.isDarkMode ? Brightness.light : Brightness.dark,
          ),
        );
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: MaterialApp(
            key: ValueKey<ThemeData>(themeNotifier.currentTheme),
            debugShowCheckedModeBanner: false,
            title: 'TalkZapp',
            theme: themeNotifier.currentTheme,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const ErrorScreen();
                } else if (snapshot.hasData) {
                  return const Home();
                } else {
                  return const LoginOrSignup();
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> checkUserLoggedIn() async {
    return firebaseOperations.isUserLoggedIn();
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Something went wrong!'),
      ),
    );
  }
}
