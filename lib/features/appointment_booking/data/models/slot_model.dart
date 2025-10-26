import 'package:cloud_firestore/cloud_firestore.dart';

class SlotModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final Timestamp dateTime;
  final bool isAvailable;
  final String? bookedBy;
  final String? bookedByName;
  final String? bookedByPhone;

  SlotModel(
      {required this.id,
      required this.doctorId,
      required this.doctorName,
      required this.dateTime,
      required this.isAvailable,
      required this.bookedBy,
      required this.bookedByName,
      required this.bookedByPhone});

  factory SlotModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return SlotModel(
      id: id ?? json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      dateTime: json['dateTime'] ?? Timestamp.now(),
      isAvailable: json['isAvailable'] ?? true,
      bookedBy: json['bookedBy'],
      bookedByName: json['bookedByName'],
      bookedByPhone: json['bookedByPhone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'dateTime': dateTime,
      'isAvailable': isAvailable,
      'bookedBy': bookedBy,
      'bookedByName': bookedByName,
      'bookedByPhone': bookedByPhone,
    };
  }
}
