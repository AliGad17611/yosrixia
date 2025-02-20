import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/helper/get_current_user_id.dart';

Future<void> updateUserInformation(
    String name, String country, String birthDate, String gender) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUserId())
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
