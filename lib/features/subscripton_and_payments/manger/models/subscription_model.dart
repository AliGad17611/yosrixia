import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/features/subscripton_and_payments/manger/helper/subscription_enum.dart';

class SubscriptionModel {
  final Timestamp startDate;
  final Timestamp expiryDate;
  final SubscriptionType type;
  final bool isActive;
  SubscriptionModel({
    required this.startDate,
    required this.expiryDate,
    required this.type,
    required this.isActive,
  });

  //* from firebase
  factory SubscriptionModel.fromFirebase(Map<String, dynamic> data) {
    return SubscriptionModel(
      startDate: data['startDate'],
      expiryDate: data['expiryDate'],
      type: SubscriptionType.values.byName(data['type']),
      isActive: data['isActive'],
    );
  }

  //* to firebase
  Map<String, dynamic> toFirebase() {
    return {
      'startDate': startDate,
      'expiryDate': expiryDate,
      'type': type.name,
      'isActive': isActive,
    };
  }
}
