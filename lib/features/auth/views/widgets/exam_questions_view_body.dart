import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/exam_questions.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/child/cubit/child_onboarding_cubit.dart';
import 'package:yosrixia/features/child/games/views/widgets/choice_option.dart';

class ExamQuestionsViewBody extends StatelessWidget {
  const ExamQuestionsViewBody({super.key, required this.questionIndex});
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    examQuestions[questionIndex],
                    style: Styles.textStyle40.copyWith(height: 0.95),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...["دائمًا", "غالبًا", "أحيانًا", "نادرًا", "أبدًا"].map(
                    (option) => ChoiceOption(
                      text: option,
                      onTap: () {
                        context
                            .read<ChildOnboardingCubit>()
                            .saveAnswer(questionIndex, option, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          
        ),
      
    );
  }
}
