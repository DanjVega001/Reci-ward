part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthInitialLogin extends AuthState {
  final UserEntity ? user;

  const AuthInitialLogin({this.user});

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


