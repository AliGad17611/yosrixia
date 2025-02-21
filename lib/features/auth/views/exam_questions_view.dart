import 'package:flutter/material.dart';
import 'package:yosrixia/features/auth/views/widgets/exam_questions_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ExamQuestionsView extends StatelessWidget {
  const ExamQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: ExamQuestionsViewBody(),

    );
  }
}
