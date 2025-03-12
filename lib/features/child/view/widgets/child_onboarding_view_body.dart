import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/auth/views/widgets/exam_questions_view_body.dart';
import 'package:yosrixia/features/child/cubit/child_onboarding_cubit.dart';
import 'package:yosrixia/features/child/cubit/child_onboarding_state.dart';
import 'package:yosrixia/features/child/view/widgets/on_boarding_widget.dart';

class ChildOnboardingViewBody extends StatelessWidget {
  const ChildOnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     BlocProvider(
        create: (context) => ChildOnboardingCubit(),
        child: BlocBuilder<ChildOnboardingCubit, ChildOnboardingState>(builder: (context, state) {
          if (state is ChildOnboardingOverviewState){
            return OnBoardingWidget(index :state.index);
          }
          else if (state is ChildOnboardingExamState){
            return ExamQuestionsViewBody(questionIndex: state.questionIndex,);
          }
          return Container();
  }));
        }
}
