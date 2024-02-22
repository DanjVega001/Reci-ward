import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/core/exceptions/exceptions.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/send_mail_reset_password_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/send_verification_email_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase signupUseCase = GetIt.instance<SignupUseCase>();
  final LoginUseCase loginUseCase = GetIt.instance<LoginUseCase>();
  final LogoutUseCase logoutUseCase = GetIt.instance<LogoutUseCase>();

  final SendMailResetPasswordUseCase sendMailResetPasswordUseCase =
      GetIt.instance<SendMailResetPasswordUseCase>();
  final ResetPasswordUsecase resetPasswordUsecase =
      GetIt.instance<ResetPasswordUsecase>();
  final SendVerificationEmailUsecase sendVerificationEmailUsecase =
      GetIt.instance<SendVerificationEmailUsecase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>(onAuthSignupRequested);

    on<AuthLoginRequested>(onAuthLoginRequested);

    on<AuthLogoutRequested>(onAuthLogoutRequested);

    on<SendMailRequested>(onSendEmail);

    on<ResetPasswordRequested>(onResetPassword);

    on<SendVerificationEmailRequested>(onSendVerificationEmailRequested);

    on<SendVerificationResetPasswordRequested>(
        onSendVerificationResetPasswordRequested);

    on<RecoverInvalidUserData>(onRecoverInvalidUserData);
  }

  void onResetPassword(
      ResetPasswordRequested event, Emitter<AuthState> emit) async {
    try {
      final validate = event.validate();
      if (validate != null) {
        return emit(AuthErrorState(error: validate.errorMessage));
      }

      Either<DioException, String> either =
          await resetPasswordUsecase.call(event.password, event.token);
      either.fold((dioException) {
        return emit(AuthErrorState(error: dioException.message!));
      }, (message) {
        return emit(AuthInitialLogin(message: message));
      });
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void onSendEmail(SendMailRequested event, Emitter<AuthState> emit) async {
    try {
      emit(SendMailInitialized());

      final validate = event.validate();
      if (validate != null) {
        return emit(SendMailFailed(error: validate.errorMessage));
      }

      Either<DioException, Map<String, dynamic>> either =
          await sendMailResetPasswordUseCase.call(event.email);
      either.fold(
          (dioException) => emit(SendMailFailed(error: dioException.message!)),
          (data) => emit(
              SendMailSuccess(message: data["message"], code: data["code"])));
    } catch (e) {
      emit(SendMailFailed(error: e.toString()));
    }
  }

  void onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {
      Either<DioException, String> logout =
          await logoutUseCase.call(event.accessToken);
      logout.fold(
          (dioException) => emit(AuthErrorState(error: dioException.message!)),
          (message) {
        emit(AuthInitialLogin(message: message));
      });
    } catch (e) {
      print('Error en onAuthLoginRequested: $e');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());

      Either<DioException, UserEntity> eitherUserEntity =
          await loginUseCase.call(event.userEntity);

      eitherUserEntity.fold((dioException) {
        emit(AuthErrorState(error: dioException.message!));
      }, (userEntity) {
        emit(AuthenticatedState(user: userEntity));
      });
    } catch (e) {
      print('Error en onAuthLoginRequested: $e');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void onAuthSignupRequested(
      AuthSignupRequested event, Emitter<AuthState> emit) async {
    try {
      final validate = event.validate();
      if (validate != null) {
        return emit(AuthErrorState(
            error: validate.errorMessage,
            code: event.code,
            userEntity: event.userEntity));
      }
      late UserEntity user = event.userEntity;

      Either<DioException, String> either = await signupUseCase.call(user);

      return either.fold(
          (dioException) => emit(AuthErrorState(error: dioException.message!)),
          (message) {
        emit(AuthInitialLogin(user: user, message: message));
      });
    } catch (e) {
      print('Error en onAuthSignupRequested: $e');
      return emit(AuthErrorState(error: e.toString()));
    }
  }

  void onSendVerificationEmailRequested(
      SendVerificationEmailRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      final validateUser = event.validate();
      if (validateUser != null) {
        return emit(
            SendVerificationEmailFailed(error: validateUser.errorMessage));
      }
      Either<DioException, Map<String, dynamic>> either =
          await sendVerificationEmailUsecase.call(event.userEntity.email);
      return either.fold(
          (dio) => emit(SendVerificationEmailFailed(error: dio.message!)),
          (data) => emit(SendVerificationEmailSuccess(
              code: data['code'],
              userEntity: event.userEntity,
              message: data['message'])));
    } on DioException catch (e) {
      print('Error en onSendVerificationEmailRequested: $e');
      return emit(SendVerificationEmailFailed(error: e.message!));
    }
  }

  void onSendVerificationResetPasswordRequested(
      SendVerificationResetPasswordRequested event,
      Emitter<AuthState> emit) async {
    try {
      emit(AuthLoadingState());
      final validateUser = event.validate();
      if (validateUser != null) {
        return emit(SendVerificationResetPasswordFailed(
            error: validateUser.errorMessage));
      }
      return emit(SendVerificationResetPasswordSuccess(
          message: "Codigo correcto", code: event.code));
    } catch (e) {
      print('Error en onSendVerificationResetPasswordRequested: $e');
    }
  }

  void onRecoverInvalidUserData(
      RecoverInvalidUserData event, Emitter<AuthState> emit) {
    return emit(SendVerificationEmailSuccess(
        code: event.code,
        userEntity: event.userEntity,
        message: "Ingrese nuevamente el codigo"));
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print("onChange=$onChange");
  }
}
