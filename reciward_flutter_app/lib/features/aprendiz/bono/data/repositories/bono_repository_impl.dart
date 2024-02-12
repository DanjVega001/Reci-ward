import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/dataresources/bono_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';

class BonoRepositoryImpl extends BonoRepository {

  final BonoService service;

  BonoRepositoryImpl({
    required this.service
  });


  @override
  Future<Either<DioException, List<BonoEntity>>> getBonos(String accessToken) async {
    try {
      final data = await service.getBonos(accessToken);
      return data.fold((err) 
        => left(err), 
      (bonos) 
        => right(bonos.map((e) => e.toEntity()).toList())
      );

    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Either<DioException, String>> saveBonoAprendiz(String accessToken, int bonoId) {
    return service.saveBonoAprendiz(accessToken, bonoId);
  }

}