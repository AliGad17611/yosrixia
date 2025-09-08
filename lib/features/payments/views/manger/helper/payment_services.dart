import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:yosrixia/core/utils/constants.dart';
import 'package:yosrixia/core/utils/styles.dart';

class PaymentServices {
  static const String apiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBMk5EZzBPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5Md3ZadFZaRTdKNE94NjRLY0cxRkRuczlzTm1wa0M3T1VDWXgyQTkySDVFNlpPMXJXeHFMbFdUTmFsQ19QbERrb2tIdWxza0hURmUyeVMyOEJ3c1l2QQ==';
  static const int integrationID = 5221980;
  static const int walletIntegrationId = 5221982;
  static const int iFrameID = 945079;

  static Future<void> initPaymob() async {
    await FlutterPaymob.instance.initialize(
      apiKey: apiKey,
      integrationID: integrationID, // Card integration ID
      walletIntegrationId: walletIntegrationId, // Wallet integration ID
      iFrameID: iFrameID, // Paymob iframe ID
    );
  }

  static Future<void> payWithCard(BuildContext context, double amount) async {
    await FlutterPaymob.instance.payWithCard(
      context: context,
      amount: amount,
      appBarColor: kPrimaryColor,
      title: Text('دفع بالبطاقة الائتمانية',
          style: Styles.textStyle20.copyWith(color: kLightBlackColor)),
      currency: 'EGP',
      onPayment: (response) {
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "🎉 Payment Success! TxID: ${response.transactionID}")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Payment Failed: ${response.message}")),
          );
        }
      },
    );
  }

  static Future<void> payWithWallet(
      BuildContext context, double amount, String number) async {
    await FlutterPaymob.instance.payWithWallet(
      context: context,
      amount: amount,
      appBarColor: kPrimaryColor,
      title: Text('دفع بالمحفظة الإلكترونية',
          style: Styles.textStyle20.copyWith(color: kLightBlackColor)),
      currency: 'EGP',
      number: number,
      onPayment: (response) {
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "🎉 Payment Success! TxID: ${response.transactionID}")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Payment Failed: ${response.message}")),
          );
        }
      },
    );
  }
}
