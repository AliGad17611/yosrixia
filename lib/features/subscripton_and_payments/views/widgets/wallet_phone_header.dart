import 'package:flutter/material.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/subscripton_and_payments/views/widgets/back_icon_button.dart';

class WalletPhoneHeader extends StatelessWidget {
  const WalletPhoneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const BackIconButton(),
      ],
    );
  }
}
