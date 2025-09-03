import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/database/firebase_services.dart';

Future<void> updateDoctorInformation(String organization, int experience,) async {
 try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseServices.instance.userId)
        .update({
      'organization': organization,
      'experience': experience,
    });
  } catch (e) {
    log('Error updating user information: $e');
  }
}