import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:yosrixia/features/appointment_booking/data/repo/slots_repo.dart';
import 'package:yosrixia/features/appointment_booking/presentation/cubits/slots_cubit/slots_cubit.dart';
import 'package:yosrixia/features/appointment_booking/presentation/views/widgets/add_appointment_view_body.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/features/widgets/background.dart';

class AddAppointmentView extends StatelessWidget {
  const AddAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: BlocProvider(
          create: (context) => SlotsCubit(slotsRepo: getIt<SlotsRepo>(), profileRepo: getIt<ProfileRepo>(), firebaseAuth: getIt<FirebaseAuth>()),
          child: const AddAppointmentViewBody()),
    );
  }
}
