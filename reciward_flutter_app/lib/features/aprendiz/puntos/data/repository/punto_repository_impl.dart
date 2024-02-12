import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/data/datasources/punto_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/repositories/punto_repository.dart';

class PuntoRepositoryImpl extends PuntoRepository{

  final PuntoService service;

  PuntoRepositoryImpl({
    required this.service
  });

  @override
  Future<Either<DioException, GetPuntoDto>> getPuntos(String accessToken) {
    return service.getPuntos(accessToken);
  }

}