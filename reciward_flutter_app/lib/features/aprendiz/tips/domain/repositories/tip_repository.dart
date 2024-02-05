import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class TipRepository {
  Future<Either<DioException, String>> getTips(String accesToken);
}
