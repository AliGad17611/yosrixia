import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/utils/app_router.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/appointment_booking/data/models/slot_model.dart';
import 'package:yosrixia/features/child/doctors/cubit/doctor_details_cubit.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DoctorSlotsWidget extends StatelessWidget {
  final String doctorId;
  final String doctorName;

  const DoctorSlotsWidget({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المواعيد المتاحة',
              style: Styles.textStyle24.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                context.push(AppRouter.addAppointment);
              },
              child: Text(
                'حجز موعد',
                style: Styles.textStyle16.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        StreamBuilder<List<SlotModel>>(
          stream: context.read<DoctorDetailsCubit>().getSlotsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'حدث خطأ في تحميل المواعيد',
                  style: Styles.textStyle16.copyWith(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد مواعيد متاحة حالياً',
                      style: Styles.textStyle18.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'يمكنك حجز موعد جديد من خلال الضغط على "حجز موعد"',
                      style: Styles.textStyle14.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            final slots = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                final slot = slots[index];
                final dateTime = slot.dateTime.toDate();
                final isToday = DateTime.now().day == dateTime.day &&
                    DateTime.now().month == dateTime.month &&
                    DateTime.now().year == dateTime.year;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd').format(dateTime),
                                style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                DateFormat('MMM').format(dateTime),
                                style: Styles.textStyle12.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isToday
                                    ? 'اليوم'
                                    : DateFormat('EEEE', 'ar').format(dateTime),
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('hh:mm a', 'ar').format(dateTime),
                                style: Styles.textStyle14.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _bookSlot(context, slot),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            'احجز',
                            style: Styles.textStyle14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Future<void> _bookSlot(BuildContext context, SlotModel slot) async {
    final profileRepo = getIt<ProfileRepo>();
    final firebaseAuth = getIt<FirebaseAuth>();

    // Get child profile
    final profileResult = await profileRepo.getChildProfile();
    profileResult.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('خطأ في تحميل بيانات الطفل: ${failure.message}')),
        );
      },
      (childProfile) async {
        // Book the slot
        await context.read<DoctorDetailsCubit>().bookAppointment(
              slot.id,
              firebaseAuth.currentUser!.uid,
              childProfile.name,
              childProfile.number,
            );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم حجز الموعد بنجاح!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
