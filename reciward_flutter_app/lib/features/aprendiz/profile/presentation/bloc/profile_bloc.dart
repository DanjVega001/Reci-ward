import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/core/exceptions/exceptions.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/usecases/update_user_usecase.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdatedUserUsecase updatedUserUsecase =
      GetIt.instance<UpdatedUserUsecase>();

  ProfileBloc() : super(ProfileInitial()) {
    on<RecoverUserProfile>(onRecoverUserProfile);

    on<UpdatedUser>(onUpdateUser);
  }

  void onRecoverUserProfile(
      RecoverUserProfile event, Emitter<ProfileState> emit) {
    emit(UserProfileState(user: event.user));
  }

  void onUpdateUser(UpdatedUser event, Emitter<ProfileState> emit) async {
    try {
      AuthException? updateUserValidator = event.validate();
      if (updateUserValidator != null) {
        emit(UpdateUserFailed(error: updateUserValidator.errorMessage));
        return;
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
}
