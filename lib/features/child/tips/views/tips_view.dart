import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/tips/views/tips_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: TipsViewBody(),);
  }
}
