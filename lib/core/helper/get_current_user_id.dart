import 'package:firebase_auth/firebase_auth.dart';

String? getCurrentUserId() {
  final User? user = FirebaseAuth.instance.currentUser;
  return user?.uid; // Returns null if no user is signed in
}
