import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/sub_character_tutorial_data.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';

class SubCharacterTutorialCubit extends Cubit<TutorialState> {
  SubCharacterTutorialCubit() : super(TutorialInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int currentIndex = 0;

  /// Check if user has completed the sub character tutorial before
  Future<void> checkTutorialStatus() async {
    try {
      emit(TutorialLoading());

      final user = _auth.currentUser;
      if (user == null) {
        emit(TutorialError(error: 'User not authenticated'));
        return;
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final hasSeenTutorial =
            userData['hasSeenSubCharacterTutorial'] ?? false;

        if (hasSeenTutorial) {
          emit(TutorialCompleted());
        } else {
          // Show tutorial starting from first step
          currentIndex = 0;
          emit(TutorialVisible(
            currentIndex: currentIndex,
            isLastStep: currentIndex == subCharacterTutorialData.length - 1,
          ));
        }
      } else {
        emit(TutorialError(error: 'User document not found'));
      }
    } catch (e) {
      log('Error checking sub character tutorial status: $e');
      emit(TutorialError(error: e.toString()));
    }
  }

  /// Move to next tutorial step
  void nextStep() {
    log('currentIndex is $currentIndex');
    if (currentIndex < 3) {
      currentIndex++;
      emit(TutorialVisible(
        currentIndex: currentIndex,
        isLastStep: currentIndex == 3,
      ));
    } else {
      completeTutorial();
    }
  }

  /// Skip the entire tutorial
  void skipTutorial() {
    completeTutorial();
  }

  /// Mark tutorial as completed and save to Firebase
  Future<void> completeTutorial() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'hasSeenSubCharacterTutorial': true,
        });
      }
      emit(TutorialCompleted());
    } catch (e) {
      log('Error completing sub character tutorial: $e');
      emit(TutorialError(error: e.toString()));
    }
  }

  /// Force show tutorial (for testing or manual trigger)
  void showTutorial() {
    currentIndex = 0;
    emit(TutorialVisible(
      currentIndex: currentIndex,
      isLastStep: currentIndex == subCharacterTutorialData.length - 1,
    ));
  }
}
