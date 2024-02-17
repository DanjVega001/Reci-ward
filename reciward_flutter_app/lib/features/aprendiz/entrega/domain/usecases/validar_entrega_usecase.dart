import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/repositories/entrega_repository.dart';

class ValidarEntregaUsecase {

  final EntregaRepository repository;


  const ValidarEntregaUsecase({
    required this.repository
  });



  Future<Either<DioException, String>> call(String accessToken, int idEntrega){
    return repository.validarEntrega(accessToken, idEntrega);
  }
}