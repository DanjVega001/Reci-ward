part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthInitialLogin extends AuthState {
  final UserEntity ? user;
  final String ? message;

  const AuthInitialLogin({this.user, this.message});

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



