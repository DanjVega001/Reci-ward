import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/data/datasources/tip_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/repositories/tip_repository.dart';

class TipRepositoryImpl extends TipRepository {
  late TipService service;

  TipRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<DioException, List<TipEntity>>> getTips(
      String accessToken) async {
    try {
      final tipmodel = await service.getTips(accessToken);
      return tipmodel.fold((dio) => left(dio),
          (tips) => right(tips.map((e) => e.toEntity()).toList()));
    } catch (e) {
      rethrow;
    }
  }
}
