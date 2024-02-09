import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/repositories/punto_repository.dart';

class GetPuntosUsecase {
  final PuntoRepository repository;

  const GetPuntosUsecase({
    required this.repository
  });

  Future<Either<DioException, GetPuntoDto>> call(String accessToken){
    return repository.getPuntos(accessToken);
  }
}