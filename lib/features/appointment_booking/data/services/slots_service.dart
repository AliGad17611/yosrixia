import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';

class SlotsService {
  final FirebaseFirestore _firestore;
  final String collectionName = 'appointment_slots';
  SlotsService({required FirebaseFirestore firestore}) : _firestore = firestore;

  //* add slot
  Future<void> addSlot(SlotModel slot) async {
    //* check if slot already exists
    final existingSlot = await _firestore
        .collection(collectionName)
        .where('doctorId', isEqualTo: slot.doctorId)
        .where('dateTime', isEqualTo: slot.dateTime)
        .get();
    if (existingSlot.docs.isNotEmpty) {
      throw Exception('هناك موعد موجود بالفعل في هذا الوقت');
    }
    await _firestore.collection(collectionName).add(slot.toJson());
  }

  //* update slot
  Future<void> updateSlot(SlotModel slot) async {
    await _firestore.collection(collectionName).doc(slot.id).update(slot.toJson());
  }

  //* get slots from firestore
  Stream<List<SlotModel>> getAvailableSlotsStream(String doctorId) async* {
    yield* _firestore
        .collection(collectionName)
        .where('doctorId', isEqualTo: doctorId)
        .where('isAvailable', isEqualTo: true)
        .orderBy('dateTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => SlotModel.fromJson(doc.data()))
            .toList());
  }

  //* book slot
  Future<void> bookSlot(String slotId, String childId, String childName,
      String childPhone) async {
    await _firestore.collection(collectionName).doc(slotId).update({
      'bookedBy': childId,
      'bookedByName': childName,
      'bookedByPhone': childPhone,
      'isAvailable': false,
    });
  }

  //* delete slot
  Future<void> deleteSlot(String slotId) async {
    await _firestore.collection(collectionName).doc(slotId).delete();
  }
}
