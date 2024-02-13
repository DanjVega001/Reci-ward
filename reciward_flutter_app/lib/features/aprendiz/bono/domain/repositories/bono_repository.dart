import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';

abstract class BonoRepository {

  Future<Either<DioException, List<BonoEntity>>> getBonos(String accessToken);

  Future<Either<DioException, String>> saveBonoAprendiz(String accessToken, int bonoId);
}