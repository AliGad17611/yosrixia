import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/features/payments/manger/helper/payment_services.dart';
import 'package:yosrixia/features/payments/views/widgets/amount_display.dart';
import 'package:yosrixia/features/payments/views/widgets/helper_text.dart';
import 'package:yosrixia/features/payments/views/widgets/pay_button.dart';
import 'package:yosrixia/features/payments/views/widgets/phone_input_field.dart';
import 'package:yosrixia/features/payments/views/widgets/phone_input_label.dart';
import 'package:yosrixia/features/payments/views/widgets/wallet_icon.dart';
import 'package:yosrixia/features/payments/views/widgets/wallet_phone_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const WalletPhoneHeader(),
                    SizedBox(height: 20.h),
                    const WalletIcon(),
                    SizedBox(height: 20.h),
                    AmountDisplay(amount: widget.amount),
                    SizedBox(height: 24.h),
                    const PhoneInputLabel(),
                    SizedBox(height: 12.h),
                    PhoneInputField(
                      controller: _phoneController,
                      validator: _validatePhoneNumber,
                    ),
                    SizedBox(height: 12.h),
                    const HelperText(),
                    SizedBox(height: 20.h),
                    PayButton(
                      isLoading: _isLoading,
                      onPressed: _processPayment,
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

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }

    String cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length == 11 && cleanNumber.startsWith('01')) {
      return null;
    } else if (cleanNumber.length == 13 && cleanNumber.startsWith('2001')) {
      return null;
    } else {
      return 'يرجى إدخال رقم هاتف مصري صحيح (01xxxxxxxxx)';
    }
  }

  String _formatPhoneNumber(String phone) {
    String cleanNumber = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.startsWith('2001')) {
      cleanNumber = cleanNumber.substring(2);
    }
    return cleanNumber;
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

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
        _showErrorSnackBar('حدث خطأ أثناء الدفع: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
