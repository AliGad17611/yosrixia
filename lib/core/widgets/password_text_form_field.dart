import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({super.key, required this.labelText});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(labelText, style: Styles.textStyle24),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            cursorColor: kSecondaryColor,
            keyboardType: TextInputType.visiblePassword,
            style: Styles.textStyle24.copyWith(color: kSecondaryColor),
            decoration: InputDecoration(
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
