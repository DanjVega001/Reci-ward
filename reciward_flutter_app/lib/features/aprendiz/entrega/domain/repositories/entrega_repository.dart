import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/historial_entity.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_cafeteria_dto.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';

abstract class EntregaRepository {
  Future<Either<DioException, String>> saveEntrega(
      String accessToken, SaveEntregaDto saveEntregaDto);


  Future<Either<DioException, String>> historialEntrega(
      String accessToken, HistorialEntity historialEntity);

  Future<Either<DioException, GetEntregaCafeteriaDto>> getEntregaCafeteria(String accessToken, int idEntrega);

}
