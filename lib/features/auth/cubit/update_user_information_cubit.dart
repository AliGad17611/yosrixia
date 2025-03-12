import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yosrixia/core/helper/get_current_id_and_role.dart';
import 'package:yosrixia/core/helper/update_user_information_method.dart';
import 'package:yosrixia/core/utils/app_router.dart';

class UpdateUserInformationCubit extends Cubit<void> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController selectedCountry = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController selectedGender = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UpdateUserInformationCubit() : super(null);

  void validateAndSubmit(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      updateUserInformation(
        nameController.text,
        selectedCountry.text,
        birthDateController.text,
        selectedGender.text,
      );

      // Navigate to the confirmation screen
      Map<String, String?> userDetails = await getCurrentUserIdAndRole();
      String? userRole = userDetails['role'] ?? '';
      if (userRole.toLowerCase() == 'child') {
        if (!context.mounted) return;
        GoRouter.of(context).push(AppRouter.childOnboarding);
      } else if (userRole.toLowerCase() == 'doctor') {
        if (!context.mounted) return;
        GoRouter.of(context).push(AppRouter.doctorExtraInformation);
      }
    }
  }
}
