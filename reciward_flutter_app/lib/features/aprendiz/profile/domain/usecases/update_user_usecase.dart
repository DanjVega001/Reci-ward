import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/repositories/profile_repository.dart';

class UpdatedUserUsecase {
  final ProfileRepository userRepository;

  UpdatedUserUsecase({required this.userRepository});

  Future<Either<DioException, String>> updateUser(
      String accessToken, UpdatedUserData userData) {
    return userRepository.updateUser(accessToken, userData);
  }
}
