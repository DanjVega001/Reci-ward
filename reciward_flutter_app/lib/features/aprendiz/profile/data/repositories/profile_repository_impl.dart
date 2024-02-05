import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/data/datasources/profile_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  late ProfileService service;

  ProfileRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<DioException, String>> updateUser(
      String accessToken, UpdatedUserData userData) {
    return service.updateUser(accessToken, userData);
  }
}
