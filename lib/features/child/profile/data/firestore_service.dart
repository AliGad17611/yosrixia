import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yosrixia/features/child/profile/models/child_info_model.dart';

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

  Future<ChildInfoModel> getUserData() async {
    DocumentSnapshot userDoc = await _firestore.collection("users").doc(userId).get();
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      ChildInfoModel childInfoModel = ChildInfoModel(
        name: userData['name'],
        imageUrl: userData['imageUrl'],
        country: userData['country'],
        birthDate: userData['birthDate'],
        gender: userData['gender'],
        number: userData['number'],
        email: userData['email'],
      );
      log("child name ${childInfoModel.name}//country ${childInfoModel.country}//birthDate ${childInfoModel.birthDate}//gender ${childInfoModel.gender}//number ${childInfoModel.number}");
      return childInfoModel;
    }
    throw Exception("User not found");
  }
}
