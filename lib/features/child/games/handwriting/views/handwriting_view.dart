import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/handwriting/handwriting_cubit/handwriting_cubit.dart';
import 'package:yosrixia/features/child/games/handwriting/views/handwriting_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';
import 'package:yosrixia/features/subscripton_and_payments/widgets/subscription_guard.dart';

class HandwritingView extends StatelessWidget {
  const HandwritingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SubscriptionGuard(
      child: BackGround(
          child: BlocProvider(
              create: (context) => HandwritingCubit(),
              child: const HandwritingViewBody())),
    );
  }
}
