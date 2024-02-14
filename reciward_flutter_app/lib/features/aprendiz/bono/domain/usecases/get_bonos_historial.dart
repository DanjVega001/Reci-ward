import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/get_historial_bono.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class GetBonosHistorialUsecase {


  final BonoRepository repository;

  const GetBonosHistorialUsecase({
    required this.repository
  });

  Future<Either<DioException, List<GetHistorialBono>>> call (String accessToken) {
    return repository.getHistorialBonos(accessToken);
  }
}