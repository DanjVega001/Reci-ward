import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase{
  final AuthRepository userRepository;

  LoginUseCase({required this.userRepository});
  
  Future<Either<DioException, UserEntity>> call(UserEntity userEntity){
    return userRepository.login(userEntity);
  } 
}