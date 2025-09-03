import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());
  Future<void> getUsersBasedOnRole() async {
    try {
      final user = FirebaseServices.instance.user;
      if (user.uid.isEmpty) {
        emit(const UsersFailure(error: 'User not authenticated'));
        return;
      }

      String currentUserId = user.uid;
      log("Current User ID: $currentUserId");

      // Get the current user's role
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (!userDoc.exists) {
        emit(const UsersFailure(error: "User document not found."));
        return;
      }

      String userRole = userDoc['role'];
      log("User Role: $userRole");

      emit(UsersLoading());

      // Fetch users with a different role
      QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isNotEqualTo: userRole)
          .orderBy('role') // Ensure proper indexing in Firestore
          .get();

      List<UserModel> users = usersSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return UserModel(
          name: data['name'] ?? 'غير معرف',
          imageUrl: data['imageUrl'] ?? '',
          uid: doc.id,
        );
      }).toList();

      // Sort users alphabetically by name
      users.sort((a, b) => a.name.compareTo(b.name));

      log("Fetched Users: $users");

      emit(UsersSuccess(usersList: users));
    } catch (e) {
      emit(UsersFailure(error: "Failed to fetch users: ${e.toString()}"));
      log("Error: ${e.toString()}");
    }
  }
}
