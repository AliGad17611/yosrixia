import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/assets_data.dart';

class DyslexiaWidget extends StatelessWidget {
  const DyslexiaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.settings);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: CircleAvatar(
          radius: 56,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            AssetsData.dyslexia,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
