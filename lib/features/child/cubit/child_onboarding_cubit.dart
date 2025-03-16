import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/exam_questions.dart';
import 'package:yosrixia/features/child/cubit/child_onboarding_state.dart';

class ChildOnboardingCubit extends Cubit<ChildOnboardingState> {
  ChildOnboardingCubit() : super(ChildOnboardingOverviewState(index: 0));
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Map<int, Map<String, String>> questionsAndAnswers = {};

  void goToNextPage(int index) {
    if (index == 4) {
      emit(ChildOnboardingExamState());
    } else {
      emit(ChildOnboardingOverviewState(index: index));
    }
  }

  void saveAnswer(int questionIndex, String answer, BuildContext context) {
    final user = _auth.currentUser;
    if (user != null) {
      questionsAndAnswers[questionIndex] = {
        'question': examQuestions[questionIndex],
        'answer': answer,
      };
      if (questionIndex == examQuestions.length - 1) {
        _sendQuestionsAndAnswersToFirebase();
        emit(ChildOnboardingOverviewState(index: 4));
      } else {
        nextQuestion();
      }
    }
  }

  void nextQuestion() {
    final currentState = state;
    if (currentState is ChildOnboardingExamState) {
      if (currentState.questionIndex < examQuestions.length - 1) {
        emit(ChildOnboardingExamState(
            questionIndex: currentState.questionIndex + 1));
      }
    }
  }

  void _sendQuestionsAndAnswersToFirebase() {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('users').doc(user.uid).update({
        'questionsAndAnswers': questionsAndAnswers
            .map((key, value) => MapEntry(key.toString(), value)),
      });
    }
  }
}
