import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class SaveBonoAprendizUsecase {

  final BonoRepository repository;

  const SaveBonoAprendizUsecase({
    required this.repository
  });

  Future<Either<DioException, String>> call(String accessToken, int bonoId){
    return repository.saveBonoAprendiz(accessToken, bonoId);
  }

}