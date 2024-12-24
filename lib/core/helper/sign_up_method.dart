import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> signUpUser(String email, String password, String role) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add user data to Firestore
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'role': role,
    });
  } catch (e) {
    log("Error during sign up: $e");
  }
}
