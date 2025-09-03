import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  /// Singleton instance
  static final FirebaseServices _instance = FirebaseServices._internal();

  /// Private constructor
  FirebaseServices._internal();

  /// Get the instance
  static FirebaseServices get instance => _instance;

  /// Get the current user
  User get user => FirebaseAuth.instance.currentUser!;

  /// Get the firestore instance
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// Get the auth instance
  FirebaseAuth get auth => FirebaseAuth.instance;

  /// Get the storage instance
  //  FirebaseStorage get storage => FirebaseStorage.instance;
  /// Get the current user id
  String get userId => user.uid;

  /// check if user is authenticated
  bool get isAuthenticated => userId.isNotEmpty;

  /// Get the current user email
  String get userEmail => user.email!;

  /// Get user data from firestore
  Future<Map<String, dynamic>> getUserData() async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
  }
  /// Get Childs data from firestore
  Future<List<Map<String, dynamic>>> getChildsData() async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore
        .collection('users')
        .where('role', isEqualTo: 'child')
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
  }   
  /// Get Doctors data from firestore
  Future<List<Map<String, dynamic>>> getDoctorsData() async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore
        .collection('users')
        .where('role', isEqualTo: 'doctor')
        .get()
        .then((value) => value.docs.map((doc) => doc.data()).toList());
  }
  /// Get custom user data from firestore
  Future<Map<String, dynamic>> getCustomUserData(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => value.data() as Map<String, dynamic>);
  } 
  /// Get user name from firestore
  Future<String> getUserName(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore.collection('users').doc(userId).get().then((value) => value.data()?['name'] as String);
  }
  /// Get user image url from firestore
  Future<String> getUserImageUrl(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID is empty');
    }
    return await firestore.collection('users').doc(userId).get().then((value) => value.data()?['imageUrl'] as String);
  }

}
