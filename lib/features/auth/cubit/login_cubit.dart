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
      return 'البريد الإلكتروني مطلوب';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 6) {
      return 'كلمة المرور ضعيفة';
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
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final String userId = userCredential.user?.uid ?? '';

      // Fetch user role from Firestore
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final String role = userDoc['role'] as String;
        emit(LoginSuccess(role: role));
      } else {
        emit(LoginFailure(error: 'المستخدم غير موجود'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(
          error: e.message ?? 'فى مشكلة في تسجيل الدخول حاول فى وقت لاحق'));
    } catch (e) {
      emit(LoginFailure(
          error: 'فى مشكلة غير معروفة في تسجيل الدخول حاول فى وقت لاحق'));
    }
  }
}
