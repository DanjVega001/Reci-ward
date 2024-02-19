import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_historial_entrega.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class HistorialEntregaUsecase {
  final EntregaRepository repository;

  const HistorialEntregaUsecase({required this.repository});

  Future<Either<DioException, List<GetHistorialEntrega>>> call(
    String accessToken,
  ) {
    return repository.historialEntrega(
      accessToken,
    );
  }
}
