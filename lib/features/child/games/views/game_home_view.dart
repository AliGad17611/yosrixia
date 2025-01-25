import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/views/widgets/game_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class GameHomeView extends StatelessWidget {
  const GameHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: Center(child:GameHomeViewBody()));
  }
}