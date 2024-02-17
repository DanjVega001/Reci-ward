import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_cafeteria_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class GetEntregaCafeteriaUsecase {
  final EntregaRepository repository;

  const GetEntregaCafeteriaUsecase({
    required this.repository
  });

  Future<Either<DioException, GetEntregaCafeteriaDto>> call(String accessToken, int idEntrega){
    return repository.getEntregaCafeteria(accessToken, idEntrega);
  }
}