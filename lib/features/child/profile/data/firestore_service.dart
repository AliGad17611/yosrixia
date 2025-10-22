import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yosrixia/core/logger/app_logger.dart';
import 'package:yosrixia/features/child/profile/data/models/child_profile_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userId = FirebaseAuth.instance.currentUser!.uid;
  Future<void> saveUserData(String name, String role, String imageUrl) async {
    await _firestore.collection("users").doc(userId).set({
      "name": name,
      "role": role,
      "imageUrl": imageUrl,
    });
  }

  Future<void> updateUserImage(String imageUrl) async {
    await _firestore.collection("users").doc(userId).update({
      "imageUrl": imageUrl,
    });
  }

  Future<bool> doesNameExist(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        final name = data['name'] as String?;
        return name != null && name.trim().isNotEmpty;
      }
      return false;
    } catch (e) {
      log("Error checking name existence: $e");
      return false;
    }
  }

  Future<ChildProfileModel> getUserData() async {
    DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      ChildProfileModel childProfileModel = ChildProfileModel(
        name: userData['name'],
        imageUrl: userData['imageUrl'],
        country: userData['country'],
        birthDate: userData['birthDate'],
        gender: userData['gender'],
        number: userData['number'],
        email: userData['email'],

      );
      AppLogger.logInfo("child name ${childProfileModel.name}//country ${childProfileModel.country}//birthDate ${childProfileModel.birthDate}//gender ${childProfileModel.gender}//number ${childProfileModel.number}");
      return childProfileModel;
    }
    throw Exception("User not found");
  }
}
