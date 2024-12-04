import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/styles.dart';

class Yosrixia extends StatelessWidget {
  const Yosrixia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'YOSRIXIA',
          style: Styles.textStyle96,
        ),
      ),
    );
  }
}
