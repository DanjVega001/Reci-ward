import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class SendVerificationEmailUsecase {
  final AuthRepository repository;

  SendVerificationEmailUsecase({required this.repository});  

  Future<Either<DioException, Map<String, dynamic>>> call(String email){
    return repository.sendVerificationEmail(email);
  }
}