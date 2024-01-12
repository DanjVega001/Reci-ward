import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/core/exceptions/exceptions.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/update_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUseCase signupUseCase = GetIt.instance<SignupUseCase>();
  final LoginUseCase loginUseCase = GetIt.instance<LoginUseCase>();
  final LogoutUseCase logoutUseCase = GetIt.instance<LogoutUseCase>();
  final UpdatedUserUsecase updatedUserUsecase =
      GetIt.instance<UpdatedUserUsecase>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>(onAuthSignupRequested);

    on<AuthLoginRequested>(onAuthLoginRequested);

    on<AuthLogoutRequested>(onAuthLogoutRequested);

    on<UpdatedUser>(onUpdateUser);
  }

  void onUpdateUser(UpdatedUser event, Emitter<AuthState> emit) async {
    try {
      AuthException? updateUserValidator = event.validate();
      if (updateUserValidator != null) {
          emit(UpdateUserFailed(error: updateUserValidator.errorMessage));
      }

      Either<DioException, String> either = await updatedUserUsecase.updateUser(
          event.accessToken, event.userData);
      either.fold(
          (dioException) =>
              emit(UpdateUserFailed(error: dioException.message!)),
          (message) => emit(UpdateUserSuccess(message: message)));
    } catch (e) {
      emit(UpdateUserFailed(error: e.toString()));
    }
  }

  void onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {
      Either<DioException, String> logout =
          await logoutUseCase.call(event.accessToken);
      logout.fold(
          (dioException) => emit(AuthErrorState(error: dioException.message!)),
          (userEntity) => emit(const AuthInitialLogin()));
    } catch (e) {
      //print('Error en onAuthLoginRequested: $e');
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
