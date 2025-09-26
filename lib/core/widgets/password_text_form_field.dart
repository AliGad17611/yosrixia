import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField(
      {super.key,
      required this.labelText,
      required this.validator,
      this.controller,
      this.horizontalPadding = 28,
      this.hintText = 'أدخل كلمة المرور هنا...'});
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(labelText, style: Styles.textStyle24),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: true,
            cursorColor: kSecondaryColor,
            keyboardType: TextInputType.visiblePassword,
            style: Styles.textStyle24.copyWith(color: kSecondaryColor),
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: kPrimaryColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
