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

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>(onAuthSignupRequested);

    on<AuthLoginRequested>(onAuthLoginRequested);

    on<AuthLogoutRequested>(onAuthLogoutRequested);

    on<SendMailRequested>(onSendEmail);

    on<ResetPasswordRequested>(onResetPassword);
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

      Either<DioException, String> either =
          await sendMailResetPasswordUseCase.call(event.email);
      either.fold(
          (dioException) => emit(SendMailFailed(error: dioException.message!)),
          (message) => emit(SendMailSuccess(message: message)));
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
      AuthException? userEntityValidator = event.validate();
      if (userEntityValidator != null) {
        return emit(AuthErrorState(error: userEntityValidator.errorMessage));
      }
      late UserEntity user = event.userEntity;

      Either<DioException, String> either = await signupUseCase.call(user);

      either.fold(
          (dioException) => emit(AuthErrorState(error: dioException.message!)),
          (message) {
        emit(AuthInitialLogin(user: user));
      });
    } catch (e) {
      print('Error en onAuthSignupRequested: $e');
      emit(AuthErrorState(error: e.toString()));
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print("onChange=$onChange");
  }
}
