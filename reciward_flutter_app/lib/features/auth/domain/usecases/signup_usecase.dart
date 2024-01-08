import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository userRepository;

  SignupUseCase({required this.userRepository});

  Future<Either<DioException, String>> call(UserEntity userEntity){
    return userRepository.signup(userEntity);
  }

}