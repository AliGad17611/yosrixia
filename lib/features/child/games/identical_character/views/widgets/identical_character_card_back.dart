import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class IdenticalCharacterCardBack extends StatelessWidget {
  const IdenticalCharacterCardBack({
    super.key,
    this.character = '؟',
    this.isMatched = false,
  });

  final String character;
  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMatched ? Colors.green : kPrimaryColor,
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: isMatched ? Colors.green.shade700 : kSecondaryColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          character,
          style: Styles.textStyle64Passion.copyWith(
            color: kBlackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
