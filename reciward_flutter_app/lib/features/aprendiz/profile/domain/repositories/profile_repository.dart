import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';

abstract class ProfileRepository {
  Future<Either<DioException, String>> updateUser(
      String accessToken, UpdatedUserData userData);
}
