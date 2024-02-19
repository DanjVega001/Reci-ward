import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<DioException, String>> signup(UserEntity aprendiz);

  Future<Either<DioException, UserEntity>> login(UserEntity user);

  Future<Either<DioException, String>> logout(String accessToken);

  Future<Either<DioException, List<FichaEntity>>> getFichas();

  Future<Either<DioException, String>> sendMailResetPassword(String email);

  Future<Either<DioException, String>> resetPassword(
      String password, String token);

  Future<Either<DioException, Map<String, dynamic>>> sendVerificationEmail(String email);
}
