import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/historial_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class HistorialEntregaUsecase {
  final EntregaRepository repository;

  const HistorialEntregaUsecase({required this.repository});

  Future<Either<DioException, String>> call(
      String accessToken, HistorialEntity historialEntity) {
    return repository.historialEntrega(accessToken, historialEntity);
  }
}
