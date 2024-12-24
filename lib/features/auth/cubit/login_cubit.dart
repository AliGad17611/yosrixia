import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/auth/cubit/login_state.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> loginUser() async {
    if (!validateForm()) return;

    emit(LoginLoading());

    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final String userId = userCredential.user?.uid ?? '';

      // Fetch user role from Firestore
      final DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final String role = userDoc['role'] as String;
        emit(LoginSuccess(role: role));
      } else {
        emit(LoginFailure(error: 'User role not found.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(error: e.message ?? 'An error occurred during login.'));
    } catch (e) {
      emit(LoginFailure(error: 'An unexpected error occurred.'));
    }
  }
}
