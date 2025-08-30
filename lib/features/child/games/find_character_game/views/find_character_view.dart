import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/find_character_game/views/find_character_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class FindCharacterView extends StatelessWidget {
  const FindCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(
      child: FindCharacterViewBody(),
    );
  }
}
