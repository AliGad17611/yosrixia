import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/exam_questions.dart';
import 'package:yosrixia/core/utils/app_router.dart';

class ExamCubit extends Cubit<int> {
  ExamCubit() : super(0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Map<int, Map<String, String>> questionsAndAnswers = {};

  void saveAnswer(int questionIndex, String answer, BuildContext context) {
    final user = _auth.currentUser;
    if (user != null) {
      questionsAndAnswers[questionIndex] = {
        'question': examQuestions[questionIndex],
        'answer': answer,
      };
      if (questionIndex == examQuestions.length - 1) {
        _sendQuestionsAndAnswersToFirebase();
        GoRouter.of(context).go(AppRouter.childHome);
      } else {
        nextQuestion();
      }
    }
  }

  void nextQuestion() {
    if (state < examQuestions.length - 1) {
      emit(state + 1);
    }
  }

  void _sendQuestionsAndAnswersToFirebase() {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('users').doc(user.uid).set({
        'questionsAndAnswers': questionsAndAnswers.map((key, value) => MapEntry(key.toString(), value)),
      });
    }
  }
}