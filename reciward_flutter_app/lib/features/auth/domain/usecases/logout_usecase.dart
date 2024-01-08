import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository userRepository;

  LogoutUseCase({required this.userRepository});

  Future<Either<DioException, String>> call(String accessToken){
    return userRepository.logout(accessToken);
  }
}