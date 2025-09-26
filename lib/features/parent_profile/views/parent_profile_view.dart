import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/parent_profile/cubit/parent_auth_cubit.dart';
import 'package:yosrixia/features/parent_profile/views/widgets/parent_profile_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentAuthCubit(),
      child: const BackGround(child: ParentProfileViewBody()),
    );
  }
}
