import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class UpdateBonoCafeteriaUsecase {
  final BonoRepository repository;

  const UpdateBonoCafeteriaUsecase({
    required this.repository
  });

  Future<Either<DioException, String>> call(String accessToken, BonoEntity bono){
    return repository.updateBono(accessToken, bono);
  }
}