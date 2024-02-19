import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';
import 'package:reciward_flutter_app/features/cafeteria/models/get_bono_cafeteria_dto.dart';

class GetBonoCafeteriaUsecase {
  final BonoRepository repository;

  const GetBonoCafeteriaUsecase({
    required this.repository
  });

  Future<Either<DioException, GetBonoCafeteriaDto>> call(String accessToken, String code) {
    return repository.getBonoCafeteria(accessToken, code);
  }
}