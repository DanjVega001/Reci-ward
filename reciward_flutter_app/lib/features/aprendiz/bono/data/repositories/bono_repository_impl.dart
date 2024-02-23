import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/dataresources/bono_service.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/models/bono_model.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/get_historial_bono.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/repositories/bono_repository.dart';
import 'package:reciward_flutter_app/features/cafeteria/models/get_bono_cafeteria_dto.dart';

class BonoRepositoryImpl extends BonoRepository {

  final BonoService service;

  BonoRepositoryImpl({
    required this.service
  });


  @override
  Future<Either<DioException, List<BonoEntity>>> getBonos(String accessToken, String rol) async {
    try {
      final data = await service.getBonos(accessToken, rol);
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

  @override
  Future<Either<DioException, List<GetHistorialBono>>> getHistorialBonos(String accessToken) {
    return service.getHistorialBonos(accessToken);
  }

  @override
  Future<Either<DioException, GetBonoCafeteriaDto>> getBonoCafeteria(String accessToken, String code) {
    return service.getBonoCafeteria(accessToken, code);
  }
  
  @override
  Future<Either<DioException, String>> validarBono(String accessToken, int idBono) {
    return service.validarBono(accessToken, idBono);
  }
  
  @override
  Future<Either<DioException, String>> updateBono(String accessToken, BonoEntity bono) {
    return service.updateBono(accessToken, BonoModel.fromEntity(bono));
  }

}