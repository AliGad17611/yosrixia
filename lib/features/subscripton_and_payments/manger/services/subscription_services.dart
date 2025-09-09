import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/helper/subscription_enum.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/models/subscription_model.dart';

class SubscriptionServices {
  //* create subscription
  static Future<void> createSubscription(SubscriptionType type) async {
    try {
      final now = Timestamp.now();
      final expiryDate = Timestamp.fromDate(now.toDate().add(Duration(
          days: type == SubscriptionType.monthly
              ? 30
              : type == SubscriptionType.quarterly
                  ? 90
                  : type == SubscriptionType.halfYearly
                      ? 180
                      : 365)));
      final subscription = SubscriptionModel(
        startDate: now,
        expiryDate: expiryDate,
        type: type,
        isActive: true,
      );
      log('Subscription: ${subscription.toFirebase()}');
      await FirebaseServices.instance.updateUserData({
        'subscription': subscription.toFirebase(),
      });
    } catch (e) {
      log('Error creating subscription: $e');
    }
  }
}
