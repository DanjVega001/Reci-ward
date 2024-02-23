import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class GetBonosUsecase {
  final BonoRepository repository;

  const GetBonosUsecase({
    required this.repository
  });

  Future<Either<DioException, List<BonoEntity>>> call(String accessToken, String rol){
    return repository.getBonos(accessToken, rol);
  }
}