import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/material/data/datasources/material_service.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/domain/repositories/material_repository.dart';

class MaterialRepositoryImpl extends MaterialRepository {
  final MaterialService service;

  MaterialRepositoryImpl({required this.service});

  @override
  Future<Either<DioException, List<MaterialEntity>>> getMateriales(
      String accessToken, String rol) async {
    try {
      final materiales = await service.getMateriales(accessToken, rol);

      return materiales.fold((dioException) => left(dioException),
          (data) => right(data.map((e) => e.toEntity()).toList()));
    } catch (e) {
      rethrow;
    }
  }
}
