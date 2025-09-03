import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/core/database/firebase_services.dart';
import 'package:yosrixia/core/helper/get_current_id_and_role.dart';
import 'package:yosrixia/features/onboarding/views/manger/welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeInitial());

 Future<void> checkUserRole() async {
    final userId = FirebaseServices.instance.userId;
    if (userId.isEmpty) {
      emit(ShowWelcomeView());
    } else {
      final role = await getCurrentUserIdAndRole();
      if (role['role'] == 'child') {
        emit(NavigateToChildHome());
      } else if (role['role'] == 'doctor') {
        emit(NavigateToDoctorHome());
      } else {
        emit(NavigateToSelectRole());
      }
    }
  }
}
