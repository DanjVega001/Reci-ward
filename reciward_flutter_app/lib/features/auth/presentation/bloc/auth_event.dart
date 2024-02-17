// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final UserEntity userEntity;

  const AuthLoginRequested({required this.userEntity});
}

class AuthLogoutRequested extends AuthEvent {
  final String accessToken;
  const AuthLogoutRequested({
    required this.accessToken,
  });
}

class AuthSignupRequested extends AuthEvent {
  final UserEntity userEntity;
  final int code;
  final int enterCode;


  const AuthSignupRequested({
    required this.userEntity, 
    required this.code,
    required this.enterCode
  });


   AuthException? validate() {
    if (enterCode != code) {
      return AuthException(errorMessage: "Incorrect code");
    }

    return null;
  }
}

class SendMailRequested extends AuthEvent {
  final String email;

  const SendMailRequested({required this.email});

  AuthException? validate() {
    if (email.isEmpty) {
      return AuthException(errorMessage: "Email is empty");
    }

    return null;
  }
}

class ResetPasswordRequested extends AuthEvent {
  final String password;
  final String confirmPassword;
  final String token;

  const ResetPasswordRequested({
    required this.password,
    required this.confirmPassword,
    required this.token,
  });

  AuthException? validate() {
    if (password != confirmPassword) {
      return AuthException(errorMessage: "Passwords dont match");
    }

    if (password.length < 6) {
      return AuthException(
          errorMessage: "Passwords cannot be less than 6 characters");
    }

    if (token.trim().isEmpty) {
      return AuthException(errorMessage: "Server error");
    }

    return null;
  }


}

class SendVerificationEmailRequested extends AuthEvent{
  final UserEntity userEntity;

  const SendVerificationEmailRequested ({
    required this.userEntity
  });


  AuthException? validate() {
    if (userEntity.aprendizEntity == null) {
      return AuthException(errorMessage: 'Not a valid user');
    }

    if (userEntity.password!.length < 6) {
      return AuthException(
          errorMessage: 'Password cannot be less than 6 characters');
    }

    if (userEntity.name == null) {
      return AuthException(errorMessage: 'Name required');
    }

    return null;
  }
}


class RecoverCodeEvent extends AuthEvent{
  final UserEntity userEntity;
  final int code;

  const RecoverCodeEvent({
    required this.code,
    required this.userEntity
  });
}
