import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/find_character_view_body.dart';
import 'package:yosrixia/features/child/games/find_character_game/manger/find_character_cubit/find_character_cubit.dart';
import 'package:yosrixia/features/widgets/background.dart';

class FindCharacterView extends StatelessWidget {
  const FindCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindCharacterCubit(),
      child: const BackGround(
        child: FindCharacterViewBody(),
      ),
    );
  }
}
