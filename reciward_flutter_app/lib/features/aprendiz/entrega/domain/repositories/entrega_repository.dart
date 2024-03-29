import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_historial_entrega.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_cafeteria_dto.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';

abstract class EntregaRepository {
  Future<Either<DioException, String>> saveEntrega(
      String accessToken, SaveEntregaDto saveEntregaDto);

  Future<Either<DioException, List<GetHistorialEntrega>>> historialEntrega(
      String accessToken);

  Future<Either<DioException, GetEntregaCafeteriaDto>> getEntregaCafeteria(
      String accessToken, int idEntrega);

  Future<Either<DioException, String>> validarEntrega(
      String accessToken, int idEntrega);
}
