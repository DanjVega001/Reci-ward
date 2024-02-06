import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/material/data/models/material_model.dart';

class MaterialService {
  
  late Dio dio;

  MaterialService(){
    dio = Dio();
  }

/*
  Future<Either<DioException, List<MaterialModel>>> getMateriales (String accessToken, String rol) async {
    try {
      
    } on DioException catch (e) {
      return left(e);
    }
  }*/
}