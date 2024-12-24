import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class NumberTextFormField extends StatelessWidget {
  const NumberTextFormField({super.key, required this.labelText, required this.validator, this.controller});
  final String labelText;
  final String? Function(String?) validator;
  final TextEditingController? controller;

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
            controller: controller,
            validator: validator,
            cursorColor: kSecondaryColor,
            keyboardType: TextInputType.phone,
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
