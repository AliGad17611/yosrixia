import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/payments/views/manger/helper/payment_services.dart';

class WalletPhoneView extends StatefulWidget {
  final double amount;

  const WalletPhoneView({
    super.key,
    required this.amount,
  });

  @override
  State<WalletPhoneView> createState() => _WalletPhoneViewState();
}

class _WalletPhoneViewState extends State<WalletPhoneView> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }

    // Remove any spaces or special characters
    String cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's a valid Egyptian mobile number
    if (cleanNumber.length == 11 && cleanNumber.startsWith('01')) {
      // Valid Egyptian mobile number (01xxxxxxxxx)
      return null;
    } else if (cleanNumber.length == 13 && cleanNumber.startsWith('2001')) {
      // Valid Egyptian mobile number with country code (+20 01xxxxxxxxx)
      return null;
    } else {
      return 'يرجى إدخال رقم هاتف مصري صحيح (01xxxxxxxxx)';
    }
  }

  String _formatPhoneNumber(String phone) {
    // Remove any non-digit characters
    String cleanNumber = phone.replaceAll(RegExp(r'[^\d]'), '');

    // If it starts with 2001, remove the country code
    if (cleanNumber.startsWith('2001')) {
      cleanNumber = cleanNumber.substring(2);
    }

    return cleanNumber;
  }

  Future<void> _processPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String formattedPhone = _formatPhoneNumber(_phoneController.text);
        await PaymentServices.payWithWallet(
          context,
          widget.amount,
          formattedPhone,
        );

        if (mounted) {
          GoRouter.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('حدث خطأ أثناء الدفع: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header with back button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'الدفع بالمحفظة الإلكترونية',
                            style: Styles.textStyle32.copyWith(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => GoRouter.of(context).pop(),
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: kPrimaryColor,
                              size: 24.sp,
                            ),
                          ),
                        ),

                        // Balance the back button
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // Wallet icon
                    Center(
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: kBlueColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          size: 40.sp,
                          color: kBlueColor,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Amount display
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: kBlueColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                            color: kBlueColor.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'المبلغ المطلوب',
                            style: Styles.textStyle18.copyWith(
                              color: kSecondaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${widget.amount.toStringAsFixed(2)} جنيه مصري',
                            style: Styles.textStyle24.copyWith(
                              color: kBlueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Phone number input section
                    Text(
                      'رقم الهاتف المسجل بالمحفظة',
                      style: Styles.textStyle20.copyWith(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Phone input field
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textDirection: TextDirection.ltr,
                        validator: _validatePhoneNumber,
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                                color: kBlueColor.withValues(alpha: 0.3)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(
                                color: kBlueColor.withValues(alpha: 0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide:
                                const BorderSide(color: kBlueColor, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Helper text
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: kBlueColor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'تأكد من أن رقم الهاتف مسجل بالمحفظة الإلكترونية (فودافون كاش، أورنج موني، إتصالات كاش)',
                              style: Styles.textStyle18.copyWith(
                                color: kSecondaryColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Pay button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _processPayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kBlueColor,
                          foregroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 3,
                          shadowColor: kBlueColor.withValues(alpha: 0.3),
                        ),
                        child: _isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 18.w,
                                    height: 18.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'جاري المعالجة...',
                                    style: Styles.textStyle20.copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment,
                                    color: kPrimaryColor,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'ادفع الآن',
                                    style: Styles.textStyle20.copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
