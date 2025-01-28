import 'package:flutter/material.dart';
import 'package:yosrixia/features/child/games/views/widgets/image_name_view_body.dart';
import 'package:yosrixia/features/widgets/background.dart';

class ImageNameView extends StatelessWidget {
  const ImageNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackGround(child: ImageNameViewBody(),);
  }
}