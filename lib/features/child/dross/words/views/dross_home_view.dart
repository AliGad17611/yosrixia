import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/dross/words/views/widgets/dross_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class DrossHomeView extends StatelessWidget {
  const DrossHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: DrossHomeViewBody());
  }
}