import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class ValidarBonoUsecase {
  final BonoRepository repository;

  const ValidarBonoUsecase({
    required this.repository
  });

  Future<Either<DioException, String>> call(String accessToken, int idBono){
    return repository.validarBono(accessToken, idBono);
  }
}