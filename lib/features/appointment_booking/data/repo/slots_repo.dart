import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:yosrixia/core/error/failure.dart';
import 'package:yosrixia/core/success/success.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';
import 'package:yosrixia/features/appointment_booking/data/services/slots_service.dart';

class SlotsRepo {
  final SlotsService _slotsService;
  SlotsRepo({required SlotsService slotsService})
      : _slotsService = slotsService;

  //* add slot
  Future<Either<Failure, Success>> addSlot(SlotModel slot) async {
    try {
      await _slotsService.addSlot(slot);
      return const Right(
          Success(icon: Icons.check, message: 'تم إضافة الموعد بنجاح'));
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* update slot
  Future<Either<Failure, Success>> updateSlot(SlotModel slot) async {
    try {
      //* check if slot dosnt booked
      if (slot.isAvailable == true) {
        await _slotsService.updateSlot(slot);
        return const Right(
            Success(icon: Icons.check, message: 'تم تحديث الموعد بنجاح'));
      } else {
        return const Left(Failure(
            icon: Icons.error, message: 'هذا الموعد محجوز ولا يمكن تحديثه'));
      }
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* get available slots
  Stream<Either<Failure, List<SlotModel>>> getAvailableSlotsStream(
      String doctorId) async* {
    try {
      final slots = _slotsService.getAvailableSlotsStream(doctorId);
      yield* slots.map((slots) => Right(slots));
    } catch (e) {
      yield Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* book slot
  Future<Either<Failure, Success>> bookSlot(String slotId, String childId,
      String childName, String childPhone) async {
    try {
      await _slotsService.bookSlot(slotId, childId, childName, childPhone);
      return const Right(
          Success(icon: Icons.check, message: 'تم حجز الموعد بنجاح'));
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }

  //* delete slot
  Future<Either<Failure, Success>> deleteSlot(String slotId) async {
    try {
      await _slotsService.deleteSlot(slotId);
      return const Right(
          Success(icon: Icons.check, message: 'تم حذف الموعد بنجاح'));
    } catch (e) {
      return Left(Failure(icon: Icons.error, message: e.toString()));
    }
  }
}
