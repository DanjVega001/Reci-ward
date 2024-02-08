import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';

abstract class MaterialRepository {

  Future<Either<DioException, List<MaterialEntity>>> getMateriales(String accessToken, String rol);
  
}