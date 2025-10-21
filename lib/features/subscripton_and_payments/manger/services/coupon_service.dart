import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/core/database/firebase_services.dart';

class CouponService {
  static Future<bool> validateCoupon(String couponCode) async {
    try {
      final doc = await FirebaseServices.instance.firestore
          .collection('coupons')
          .doc(couponCode)
          .get();

      if (!doc.exists) return false;

      final data = doc.data()!;
      final expiryDate = (data['expiryDate'] as Timestamp).toDate();
      final isUsed = data['isUsed'] ?? false;
      final isActive = data['isActive'] ?? true;

      return isActive && !isUsed && expiryDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  static Future<void> markCouponAsUsed(String couponCode) async {
    try {
      await FirebaseServices.instance.firestore
          .collection('coupons')
          .doc(couponCode)
          .update({
        'isUsed': true,
        'usedAt': Timestamp.now(),
        'usedBy': FirebaseServices.instance.userId,
      });
    } catch (e) {
      throw Exception('Failed to mark coupon as used');
    }
  }
}
