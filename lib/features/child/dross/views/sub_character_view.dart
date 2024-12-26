import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/dross/views/widgets/sub_character_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class SubCharacterView extends StatelessWidget {
  const SubCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: SubCharacterViewBody(),);
  }
}