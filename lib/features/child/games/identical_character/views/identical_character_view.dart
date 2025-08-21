import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/identical_character/views/identical_character_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class IdenticalCharacterView extends StatelessWidget {
  const IdenticalCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: IdenticalCharacterViewBody(),);
  }
}
