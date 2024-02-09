import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';

abstract class EntregaRepository {

  Future<Either<DioException, String>> saveEntrega(String accessToken, SaveEntregaDto saveEntregaDto);

}