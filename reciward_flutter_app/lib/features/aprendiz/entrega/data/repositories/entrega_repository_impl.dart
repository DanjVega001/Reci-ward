import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/data/dataresources/entrega_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class EntregaRepositoryImpl extends EntregaRepository {

  final EntregaService service;

  EntregaRepositoryImpl({
    required this.service
  });

  @override
  Future<Either<DioException, String>> saveEntrega(String accessToken, SaveEntregaDto saveEntregaDto) {
    return service.saveEntrega(accessToken, saveEntregaDto);
  }

}