import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/puzzel/views/widgets/puzzel_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class PuzzelView extends StatelessWidget {
  const PuzzelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: PuzzelViewBody());
  }
}
