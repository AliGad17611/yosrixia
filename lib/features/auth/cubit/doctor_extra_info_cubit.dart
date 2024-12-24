import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/update_doctor_information.dart';
import 'package:yosrixia/core/utils/app_router.dart';

class DoctorExtraInfoCubit extends Cubit<void> {
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DoctorExtraInfoCubit() : super(null);

  void validateAndSubmit(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      updateDoctorInformation(
        organizationController.text,
        int.parse(experienceController.text),
      );

      // Navigate to the confirmation screen
     

        GoRouter.of(context).push(AppRouter.doctorHome);
      
    }
  }
}
