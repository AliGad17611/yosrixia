import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/dross/views/widgets/gomal_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class GomalHomeView extends StatelessWidget {
  const GomalHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: GomalHomeViewBody(),);
  }
}