
import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class DyslexiaWidget extends StatelessWidget {
  const DyslexiaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
        radius: 56,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          AssetsData.dyslexia,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
