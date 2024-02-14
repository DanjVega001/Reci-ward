import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/models/bono_model.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/get_historial_bono.dart';

class BonoService {
  late Dio dio;

  BonoService() {
    dio = Dio();
  }

  Future<Either<DioException, List<BonoModel>>> getBonos(
      String accessToken) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );
    try {
      final response = await dio.get(urlApiGetBonos, options: options);

      if (response.statusCode == 200) {
        final data = response.data;
        final bonos = (data as List).map((e) => BonoModel.fromJson(e)).toList();

        return right(bonos);
      }

      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
      ));
    } on DioException catch (e) {
      print("Error en get bonos BonoService ${e.message}");
      return left(e);
    }
  }

  Future<Either<DioException, String>> saveBonoAprendiz(
      String accessToken, int bonoId) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );
    try {
      final response = await dio.post(urlApiSaveBonoAp,
          data: {"bono_id": bonoId}, options: options);
      if (response.statusCode == 201) {
        String message = response.data["message"];
        return right(message);
      }

      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.data["error"],
      ));
    } on DioException catch (e) {
      print("Error en get bonos BonoService ${e.message}");
      return left(e);
    }
  }

  Future<Either<DioException, List<GetHistorialBono>>> getHistorialBonos(
      String accessToken) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );


    try {
      final response = await dio.get(urlApiGetHistorialBono, options: options);
      if (response.statusCode == 200) {
        final data = (response.data as List).map((e) => GetHistorialBono.fromJson(e)).toList();
        return right(data);
      }

      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.data["error"],
      ));
    } on DioException catch (e) {
      print("Error en get historialBonos service ${e.message}");
      return left(e);
    }
  }
}
