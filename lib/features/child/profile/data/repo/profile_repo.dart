import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/helper/picker.dart';
import 'package:yosrixia/core/logger/app_logger.dart';
import 'package:yosrixia/core/success/success.dart';
import 'package:yosrixia/features/child/profile/data/dataSources/profile_service.dart';
import 'package:yosrixia/features/child/profile/data/dataSources/storage_service.dart';
import 'package:yosrixia/features/child/profile/data/models/child_profile_model.dart';
import 'package:yosrixia/features/child/profile/data/models/doctor_profile_model.dart';

class ProfileRepo {
  final ProfileService _profileService;
  final StorageService _storageService;
  ProfileRepo({required ProfileService profileService, required StorageService storageService})
      : _profileService = profileService,
        _storageService = storageService;

  //* get doctor profile
  Future<Either<Failure, DoctorProfileModel>> getDoctorProfile() async {
    try {
      return await _profileService.getDoctorProfile();
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* update doctor profile
  Future<Either<Failure, Success>> updateDoctorProfile(
      DoctorProfileModel doctorProfile) async {
    try {
      return await _profileService.updateDoctorProfile(doctorProfile);
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* get child profile
  Future<Either<Failure, ChildProfileModel>> getChildProfile() async {
    try {
      return await _profileService.getChildProfile();
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* update child profile
  Future<Either<Failure, Success>> updateChildProfile(
      ChildProfileModel childProfile) async {
    try {
      return await _profileService.updateChildProfile(childProfile);
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* delete user profile
  Future<Either<Failure, Success>> deleteProfile() async {
    try {
      return await _profileService.deleteProfile();
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* update user image
  Future<Either<Failure, File>> updateUserImage() async {
    try {
      AppLogger.logInfo('updateUserImage');
      File file = await Picker.pickImage();
      AppLogger.logInfo('file: $file');
      String imageUrl = await _storageService.uploadProfileImage(file);
      AppLogger.logInfo('imageUrl: $imageUrl');
      if (imageUrl.isNotEmpty) {
        await _profileService.updateUserImage(imageUrl);
        AppLogger.logInfo('imageUrl updated');
      }
      return Right(file);
    } catch (e) {
      AppLogger.logInfo('updateUserImage error: $e');
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }
}