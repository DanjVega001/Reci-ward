import 'package:dartz/dartz.dart';
import 'package:dio/src/dio_exception.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/domain/repositories/material_repository.dart';

class MaterialRepositoryImpl extends MaterialRepository {


  @override
  Future<Either<DioException, List<MaterialEntity>>> getMateriales(String accessToken, String rol) {
    throw UnimplementedError();
  }

}