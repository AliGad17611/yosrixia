import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/view/widgets/child_home_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ChildHomeView extends StatelessWidget {
  const ChildHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ChildHomeViewBody());
  }
}