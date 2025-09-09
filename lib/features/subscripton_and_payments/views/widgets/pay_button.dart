import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/button_content.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/loading_content.dart';

class PayButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const PayButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlueColor,
          foregroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 3,
          shadowColor: kBlueColor.withValues(alpha: 0.3),
        ),
        child: isLoading ? const LoadingContent() : const ButtonContent(),
      ),
    );
  }
}
