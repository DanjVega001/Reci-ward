import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository userRepository;

  ResetPasswordUsecase({required this.userRepository});  

  Future<Either<DioException, String>> call(String password, String token){
    return userRepository.resetPassword(password, token);
  }
}