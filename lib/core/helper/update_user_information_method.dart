import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/database/firebase_services.dart';

Future<void> updateUserInformation(
    String name, String country, String birthDate, String gender) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseServices.instance.userId)
        .update({
      'name': name,
      'country': country,
      'birthDate': birthDate,
      'gender': gender,
    });
  } catch (e) {
    log('Error updating user information: $e');
  }
}
