import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  List<UserModel> _allUsers = [];
  String _searchQuery = '';
  StreamSubscription<QuerySnapshot>? _usersSubscription;

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

      // Store all users and apply current search filter
      _allUsers = users;

      log("Fetched Users: $users");

      // Apply search filter if exists
      final filteredUsers = _filterUsers();
      log("Emitting UsersSuccess with ${filteredUsers.length} users");
      emit(UsersSuccess(usersList: filteredUsers));
    } catch (e) {
      emit(UsersFailure(error: "Failed to fetch users: ${e.toString()}"));
      log("Error: ${e.toString()}");
    }
  }

  void searchUsers(String query) {
    _searchQuery = query.trim().toLowerCase();
    final filteredUsers = _filterUsers();
    log("Search Query: '$_searchQuery'");
    log("Filtered Users Count: ${filteredUsers.length}");
    emit(UsersSuccess(usersList: filteredUsers));
  }

  void listenToUsersBasedOnRole() async {
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

      // Cancel any existing subscription
      await _usersSubscription?.cancel();

      // Listen to users with a different role
      _usersSubscription = FirebaseFirestore.instance
          .collection('users')
          .where('role', isNotEqualTo: userRole)
          .orderBy('role') // Ensure proper indexing in Firestore
          .snapshots()
          .listen((usersSnapshot) {
        List<UserModel> users = usersSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data();
          return UserModel(
            name: data['name'] ?? 'غير معرف',
            imageUrl: data['imageUrl'] ?? '',
            uid: doc.id,
          );
        }).toList();

        // Sort users alphabetically by name
        users.sort((a, b) => a.name.compareTo(b.name));

        // Store all users and apply current search filter
        _allUsers = users;

        log("Real-time update: Fetched Users: $users");

        // Apply search filter if exists
        final filteredUsers = _filterUsers();
        log("Emitting UsersSuccess with ${filteredUsers.length} users");
        emit(UsersSuccess(usersList: filteredUsers));
      }, onError: (error) {
        emit(UsersFailure(
            error: "Failed to listen to users: ${error.toString()}"));
        log("Error: ${error.toString()}");
      });
    } catch (e) {
      emit(UsersFailure(
          error: "Failed to setup users listener: ${e.toString()}"));
      log("Error: ${e.toString()}");
    }
  }

  List<UserModel> _filterUsers() {
    if (_searchQuery.isEmpty) {
      return _allUsers;
    }

    return _allUsers.where((user) {
      // Convert both search query and user name to lowercase for case-insensitive search
      final userName = user.name.toLowerCase().trim();
      final searchTerm = _searchQuery.toLowerCase().trim();

      // Check if the user name contains the search term
      final matches = userName.contains(searchTerm);

      log("Checking user: '$userName' against search: '$searchTerm' - Match: $matches");

      return matches;
    }).toList();
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}
