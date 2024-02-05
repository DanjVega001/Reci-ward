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

  const AuthErrorState({required this.error});
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

  const SendMailSuccess({required this.message});
}

final class SendMailFailed extends AuthState {
  final String error;

  const SendMailFailed({required this.error});
}

final class SendMailInitialized extends AuthState {}
