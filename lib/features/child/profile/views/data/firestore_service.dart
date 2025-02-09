import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String name, String role, String imageUrl) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await _firestore.collection("users").doc(userId).set({
      "name": name,
      "role": role,
      "imageUrl": imageUrl,
    });
  }
}
