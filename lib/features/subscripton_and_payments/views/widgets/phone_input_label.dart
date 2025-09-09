import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class PhoneInputLabel extends StatelessWidget {
  const PhoneInputLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'رقم الهاتف المسجل بالمحفظة',
      style: Styles.textStyle20.copyWith(
        color: kSecondaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
