import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/dross/gomal/views/widgets/gomal_level_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class GomalLevelView extends StatelessWidget {
  const GomalLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: GomalLevelViewBody(),);
  }
}