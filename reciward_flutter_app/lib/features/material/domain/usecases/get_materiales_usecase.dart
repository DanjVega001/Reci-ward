import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/domain/repositories/material_repository.dart';

class GetMaterialesUsecase {

  final MaterialRepository materialRepository;

  const GetMaterialesUsecase({required this.materialRepository});


  Future<Either<DioException, List<MaterialEntity>>> call (String accessToken, String rol) {
    return materialRepository.getMateriales(accessToken, rol);
  }
  
}