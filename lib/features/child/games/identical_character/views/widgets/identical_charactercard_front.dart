import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class IdenticalCharactercardFront extends StatelessWidget {
  const IdenticalCharactercardFront({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsData.identicalCharacter,
    );
  }
}
