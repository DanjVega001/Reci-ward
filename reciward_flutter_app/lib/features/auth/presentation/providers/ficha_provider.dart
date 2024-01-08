import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/usecases/get_fichas_usecase.dart';
import 'package:get_it/get_it.dart';

class FichaProvider extends ChangeNotifier {
  late List<FichaEntity> fichas;
  final GetFichasUseCase getFichasUseCase = GetIt.instance<GetFichasUseCase>();



  Future<Either<DioException, List<FichaEntity>>> getFichas () {
    return getFichasUseCase.call();
  }


}