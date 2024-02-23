import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class SendMailResetPasswordUseCase {
  final AuthRepository userRepository;

  SendMailResetPasswordUseCase({required this.userRepository});  

  Future<Either<DioException, Map<String, dynamic>>> call(String email){
    return userRepository.sendMailResetPassword(email);
  }
}