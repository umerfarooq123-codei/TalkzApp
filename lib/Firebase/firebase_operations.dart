import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseOperations {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  FirebaseOperations() {
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  Future<String> emailAndPassUser({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        saveUserData(
            email: email,
            password: password,
            username: username,
            firstName: firstName,
            lastName: lastName);
      });
      return "User has been created successfully";
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> saveUserData({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    try {
      Map<String, String> userData = {
        'email': email,
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      };
      database.ref('users').child(username).set(userData);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signIn({
    required String password,
    required String email,
  }) async {
    try {
      return firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log(e.code);
      throw Exception(e.code);
    }
  }

  bool isUserLoggedIn() {
    return firebaseAuth.currentUser != null;
  }
}
