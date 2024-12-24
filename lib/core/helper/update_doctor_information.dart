import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/helper/get_current_user_id.dart';

Future<void> updateDoctorInformation(String organization, int experience,) async {
 try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(getCurrentUserId())
        .update({
      'organization': organization,
      'experience': experience,
    });
  } catch (e) {
    log('Error updating user information: $e');
  }
}