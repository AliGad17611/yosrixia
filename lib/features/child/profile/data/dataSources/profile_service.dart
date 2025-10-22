import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/success/success.dart';
import 'package:yosrixia/features/child/profile/models/child_profile_model.dart';
import 'package:yosrixia/features/child/profile/models/doctor_profile_model.dart';

class ProfileService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  ProfileService(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

//* get current user id
  String? get _currentUserId => _auth.currentUser?.uid;

  //* get doctor profile from firestore
  Future<Either<Failure, DoctorProfileModel>> getDoctorProfile() async {
    if (_currentUserId == null) {
      return const Left(
          Failure(icon: Icons.error, message: 'User not authenticated'));
    }
    final profileDoc =
        await _firestore.collection('users').doc(_currentUserId).get();
    if (profileDoc.exists) {
      final profileData = profileDoc.data() as Map<String, dynamic>;
      return Right(DoctorProfileModel.fromJson(profileData));
    }
    return const Left(Failure(icon: Icons.error, message: 'Profile not found'));
  }

  //* update doctor profile in firestore
  Future<Either<Failure, Success>> updateDoctorProfile(
      DoctorProfileModel doctorProfile) async {
    if (_currentUserId == null) {
      return const Left(
          Failure(icon: Icons.error, message: 'User not authenticated'));
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .update(doctorProfile.toJson());
    return const Right(
        Success(icon: Icons.check, message: 'Profile updated successfully'));
  }

  //* get child profile from firestore
  Future<Either<Failure, ChildProfileModel>> getChildProfile() async {
    if (_currentUserId == null) {
      return const Left(
          Failure(icon: Icons.error, message: 'User not authenticated'));
    }
    final profileDoc =
        await _firestore.collection('users').doc(_currentUserId).get();
    if (profileDoc.exists) {
      final profileData = profileDoc.data() as Map<String, dynamic>;
      return Right(ChildProfileModel.fromJson(profileData));
    }
    return const Left(Failure(icon: Icons.error, message: 'Profile not found'));
  }

  //* update child profile in firestore
  Future<Either<Failure, Success>> updateChildProfile(
      ChildProfileModel childProfile) async {
    if (_currentUserId == null) {
      return const Left(
          Failure(icon: Icons.error, message: 'User not authenticated'));
    }
    await _firestore
        .collection('users')
        .doc(_currentUserId)
        .update(childProfile.toJson());
    return const Right(
        Success(icon: Icons.check, message: 'Profile updated successfully'));
  }

  //* delete userprofile from firestore
  Future<Either<Failure, Success>> deleteProfile() async {
    if (_currentUserId == null) {
      return const Left(
          Failure(icon: Icons.error, message: 'User not authenticated'));
    }
    await _firestore.collection('users').doc(_currentUserId).delete();
    return const Right(
        Success(icon: Icons.check, message: 'Profile deleted successfully'));
  }
}
