import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class SaveEntregaUsecase {
  final EntregaRepository repository;

  const SaveEntregaUsecase({required this.repository});

  Future<Either<DioException, String>> call(
      String accessToken, SaveEntregaDto saveEntregaDto) {
    return repository.saveEntrega(accessToken, saveEntregaDto);
  }

  getHistorial(String accessToken) {}
}
