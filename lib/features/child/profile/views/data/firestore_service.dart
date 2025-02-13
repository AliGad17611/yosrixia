import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
