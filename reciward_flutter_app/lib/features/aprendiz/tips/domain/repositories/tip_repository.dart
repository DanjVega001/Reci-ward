import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';

abstract class TipRepository {
  Future<Either<DioException, List<TipEntity>>> getTips(String accesToken);
}
