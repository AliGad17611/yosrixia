import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textDirection: TextDirection.ltr,
        validator: validator,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(13),
        ],
        style: Styles.textStyle20.copyWith(
          color: kSecondaryColor,
        ),
        decoration: InputDecoration(
          hintText: '01xxxxxxxxx',
          hintStyle: Styles.textStyle18.copyWith(
            color: kSecondaryColor.withValues(alpha: 0.5),
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: kBlueColor,
            size: 20.sp,
          ),
          filled: true,
          fillColor: kPrimaryColor,
          border: _buildBorder(kBlueColor.withValues(alpha: 0.3)),
          enabledBorder: _buildBorder(kBlueColor.withValues(alpha: 0.3)),
          focusedBorder: _buildBorder(kBlueColor, width: 2),
          errorBorder: _buildBorder(Colors.red, width: 2),
          focusedErrorBorder: _buildBorder(Colors.red, width: 2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
