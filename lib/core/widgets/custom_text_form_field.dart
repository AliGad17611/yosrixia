import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.labelText, required this.controller, this.validator, this.readOnly=false, this.onTap, this.suffixIcon, this.hintText});

  final String labelText;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final String? hintText;
  final Widget? suffixIcon;

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
            onTap: onTap??() {},
            controller: controller,
            validator: validator,
            readOnly: readOnly,
            cursorColor: kSecondaryColor,
            keyboardType: TextInputType.text,
            style: Styles.textStyle24.copyWith(color: kSecondaryColor),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText??"",
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
