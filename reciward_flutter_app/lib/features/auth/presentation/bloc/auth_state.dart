// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

@immutable
final class AuthInitialLogin extends AuthState {
  UserEntity? user;
  String? message;

  AuthInitialLogin({this.user, this.message});
}

final class AuthenticatedState extends AuthState {
  final UserEntity user;

  const AuthenticatedState({required this.user});
}

final class UnauthenticatedState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String error;
  final int ? code;
  final UserEntity ? userEntity;

  const AuthErrorState({required this.error, this.code, this.userEntity});
}

final class AuthLoadingState extends AuthState {}

final class UpdateUserFailed extends AuthState {
  final String error;
  const UpdateUserFailed({required this.error});
}

final class UpdateUserSuccess extends AuthState {
  final String message;

  const UpdateUserSuccess({required this.message});
}

final class SendMailSuccess extends AuthState {
  final String message;
  final int code;

  const SendMailSuccess({required this.message, required this.code});
}

final class SendMailFailed extends AuthState {
  final String error;

  const SendMailFailed({required this.error});
}

final class SendMailInitialized extends AuthState {}

final class SendVerificationEmailSuccess extends AuthState {
  final UserEntity userEntity;
  final int code;
  final String message;

  const SendVerificationEmailSuccess({
    required this.code,
    required this.userEntity,
    required this.message
  });
}

final class SendVerificationEmailFailed extends AuthState {
  final String error;

  const SendVerificationEmailFailed({
    required this.error
  });
}


final class SendVerificationResetPasswordSuccess extends AuthState {
  final String message;
  final int code;

  const SendVerificationResetPasswordSuccess({required this.message, required this.code});
}

final class SendVerificationResetPasswordFailed extends AuthState {
  final String error;
  final int ? code;

  const SendVerificationResetPasswordFailed({required this.error, this.code});
}