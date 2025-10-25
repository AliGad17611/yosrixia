import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/di/dependency_injection.dart';
import 'package:yosrixia/core/utils/styles.dart';
import 'package:yosrixia/features/appointment_booking/data/repo/slots_repo.dart';
import 'package:yosrixia/features/appointment_booking/presentation/cubits/slots_cubit/slots_cubit.dart';
import 'package:yosrixia/features/appointment_booking/presentation/views/widgets/add_slot_form.dart';
import 'package:yosrixia/features/child/profile/data/repo/profile_repo.dart';
import 'package:yosrixia/features/widgets/background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddSlotView extends StatelessWidget {
  const AddSlotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGround(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إضافة موعد جديد',
            style: Styles.textStyle24.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocProvider(
          create: (context) => SlotsCubit(slotsRepo: getIt<SlotsRepo>(), profileRepo: getIt<ProfileRepo>(), firebaseAuth: getIt<FirebaseAuth>()),
          child: const Directionality(
            textDirection: TextDirection.rtl,
            child: AddSlotForm(),
          ),
        ),
      ),
    );
  }
}
