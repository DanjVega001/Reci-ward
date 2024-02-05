part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class RecoverUserProfile extends ProfileEvent {
  final UserEntity user;

  const RecoverUserProfile({required this.user});
}

class UpdatedUser extends ProfileEvent {
  final UpdatedUserData userData;
  final UserEntity? user;
  final bool updatePassword;
  final String accessToken;
  final String confirmPassword;

  const UpdatedUser(
      {required this.userData,
      required this.updatePassword,
      required this.accessToken,
      required this.confirmPassword,
      this.user});

  AuthException? validate() {
    if (updatePassword && (userData.password != confirmPassword)) {
      return AuthException(errorMessage: 'Passwords don\' match');
    }

    if (updatePassword &&
        (userData.password!.length < 6 || userData.oldPassword!.length < 6)) {
      return AuthException(
          errorMessage: 'Password cannot be less than 6 characters');
    }

    if (updatePassword && (userData.password != confirmPassword)) {
      return AuthException(errorMessage: 'Password dont match');
    }

    if (userData.apellido == null) {
      return AuthException(errorMessage: 'Apellido required');
    }

    if (userData.name == null) {
      return AuthException(errorMessage: 'Name required');
    }

    if (userData.email == null) {
      return AuthException(errorMessage: 'Email required');
    }

    return null;
  }
}

class KillUser extends ProfileEvent {}

class EndSession extends ProfileEvent {
  final String accessToken;

  const EndSession({required this.accessToken});
}
