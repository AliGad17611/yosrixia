import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/helper/exam_questions.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/auth/cubit/exam_cubit.dart';
import 'package:yosrixia/features/child/games/views/widgets/choice_option.dart';

class ExamQuestionsViewBody extends StatelessWidget {
  const ExamQuestionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExamCubit(),
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocBuilder<ExamCubit, int>(
            builder: (context, questionIndex) {
              return Padding(
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
                              .read<ExamCubit>()
                              .saveAnswer(questionIndex, option, context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
