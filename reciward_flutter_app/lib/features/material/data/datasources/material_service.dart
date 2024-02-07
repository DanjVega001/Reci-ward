import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/material/data/models/material_model.dart';

class MaterialService {
  
  late Dio dio;

  MaterialService(){
    dio = Dio();
  }


  Future<Either<DioException, List<MaterialModel>>> getMateriales (String accessToken, String rol) async {

    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );

    try {
      String urlApi;
      if (rol == 'aprendiz') {
        urlApi = urlApiGetMateriales;
      } else {
        urlApi = urlApiMaterialesCafeteria;
      }

      final response = await dio.get(urlApi, options: options);

      if (response.statusCode == 200) {
        final results = response.data;
        final materiales =
            (results as List).map((e) => MaterialModel.fromJson(e)).toList();
        return right(materiales);
      } else {
        return left(DioException(
          requestOptions: response.requestOptions,
          message: response.statusMessage,
        ));
      }
    } on DioException catch (e) {
      return left(e);
    }
  }
}