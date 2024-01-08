import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class GetFichasUseCase {
  final AuthRepository userRepository;

  GetFichasUseCase({required this.userRepository});

  Future<Either<DioException, List<FichaEntity>>> call(){
    return userRepository.getFichas();
  }
}