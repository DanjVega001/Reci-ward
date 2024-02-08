import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/repositories/tip_repository.dart';

class GetTipsUsecase {
  final TipRepository tipRepository;

  GetTipsUsecase({required this.tipRepository});

  Future<Either<DioException, List<TipEntity>>> getTip(String accessToken) {
    return tipRepository.getTips(accessToken);
  }
}
