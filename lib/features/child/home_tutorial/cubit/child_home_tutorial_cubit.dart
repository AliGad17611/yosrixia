import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/child_home_tutorial_data.dart';
import 'package:yosrixia/features/child/dross/tutorial/cubit/tutorial_state.dart';

class ChildHomeTutorialCubit extends Cubit<TutorialState> {
  ChildHomeTutorialCubit() : super(TutorialInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int currentIndex = 0;

  /// Check if user has completed the child home tutorial before
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
        final hasSeenTutorial = userData['hasSeenChildHomeTutorial'] ?? false;

        if (hasSeenTutorial) {
          emit(TutorialCompleted());
        } else {
          // Show tutorial starting from first step
          currentIndex = 0;
          emit(TutorialVisible(
            currentIndex: currentIndex,
            isLastStep: currentIndex == childHomeTutorialData.length - 1,
          ));
        }
      } else {
        emit(TutorialError(error: 'User document not found'));
      }
    } catch (e) {
      log('Error checking child home tutorial status: $e');
      emit(TutorialError(error: e.toString()));
    }
  }

  /// Move to next tutorial step
  void nextStep() {
    if (currentIndex < childHomeTutorialData.length - 1) {
      currentIndex++;
      emit(TutorialVisible(
        currentIndex: currentIndex,
        isLastStep: currentIndex == childHomeTutorialData.length - 1,
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
          'hasSeenChildHomeTutorial': true,
        });
      }
      emit(TutorialCompleted());
    } catch (e) {
      log('Error completing child home tutorial: $e');
      emit(TutorialError(error: e.toString()));
    }
  }

  /// Force show tutorial (for testing or manual trigger)
  void showTutorial() {
    currentIndex = 0;
    emit(TutorialVisible(
      currentIndex: currentIndex,
      isLastStep: currentIndex == childHomeTutorialData.length - 1,
    ));
  }
}
