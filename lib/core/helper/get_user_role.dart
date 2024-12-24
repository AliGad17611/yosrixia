import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> getUserRole(String userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return userDoc.data()?['role']; // Access the 'role' field
    } else {
      log("User document does not exist.");
      return null;
    }
  } catch (e) {
    log("Error fetching user role: $e");
    return null;
  }
}
