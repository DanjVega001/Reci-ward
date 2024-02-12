import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';

abstract class PuntoRepository {

  Future<Either<DioException, GetPuntoDto>> getPuntos(String accessToken);
}