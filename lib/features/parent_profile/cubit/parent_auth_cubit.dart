import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'parent_auth_state.dart';

class ParentAuthCubit extends Cubit<ParentAuthState> {
  ParentAuthCubit() : super(ParentAuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> validateParentPassword(String enteredPassword) async {
    emit(ParentAuthLoading());

    try {
      // Get current user
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(ParentAuthError('المستخدم غير مسجل الدخول'));
        return;
      }

      // Get user email for re-authentication
      String? userEmail = currentUser.email;
      if (userEmail == null) {
        emit(ParentAuthError('لا يمكن العثور على البريد الإلكتروني للمستخدم'));
        return;
      }

      // Create credential with email and entered password
      AuthCredential credential = EmailAuthProvider.credential(
        email: userEmail,
        password: enteredPassword,
      );

      // Re-authenticate user with the entered password
      await currentUser.reauthenticateWithCredential(credential);

      // If re-authentication succeeds, the password is correct
      emit(ParentAuthSuccess());
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'كلمة المرور غير صحيحة';
          break;
        case 'too-many-requests':
          errorMessage = 'تم إجراء محاولات كثيرة. يرجى المحاولة لاحقاً';
          break;
        case 'network-request-failed':
          errorMessage = 'خطأ في الاتصال بالإنترنت';
          break;
        case 'user-mismatch':
          errorMessage = 'خطأ في بيانات المستخدم';
          break;
        case 'user-not-found':
          errorMessage = 'المستخدم غير موجود';
          break;
        case 'invalid-credential':
          errorMessage = 'كلمة المرور غير صحيحة';
          break;
        default:
          errorMessage =
              'حدث خطأ أثناء التحقق من كلمة المرور: ${e.message ?? e.code}';
      }
      emit(ParentAuthError(errorMessage));
    } catch (e) {
      emit(ParentAuthError('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
