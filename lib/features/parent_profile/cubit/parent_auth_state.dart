part of 'parent_auth_cubit.dart';

abstract class ParentAuthState {}

class ParentAuthInitial extends ParentAuthState {}

class ParentAuthLoading extends ParentAuthState {}

class ParentAuthSuccess extends ParentAuthState {}

class ParentAuthError extends ParentAuthState {
  final String message;

  ParentAuthError(this.message);
}
