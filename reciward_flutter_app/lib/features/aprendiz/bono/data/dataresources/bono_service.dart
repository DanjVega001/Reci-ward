import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/data/models/bono_model.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/get_historial_bono.dart';
import 'package:reciward_flutter_app/features/cafeteria/models/get_bono_cafeteria_dto.dart';

class BonoService {
  late Dio dio;

  BonoService() {
    dio = Dio();
  }

  Future<Either<DioException, List<BonoModel>>> getBonos(
      String accessToken, String rol) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );
    try {
      String url;
      if (rol=="aprendiz") {
        url = urlApiGetBonos;
      } else {
        url = urlApiGetBonosCafeteria;
      }
      final response = await dio.get(url, options: options);
      print(response);
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
        final data = (response.data["bonos"] as List)
            .map((e) => GetHistorialBono.fromJson(e))
            .toList();
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

  Future<Either<DioException, GetBonoCafeteriaDto>> getBonoCafeteria(
      String accessToken, String code) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );

    try {
      final response =
          await dio.get("$urlApiGetHistorialBono/$code", options: options);
      print("bonos"+response.data);
      if (response.statusCode == 200) {
        final data = GetBonoCafeteriaDto.fromJson(response.data);
        return right(data);
      }

      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.data["error"],
      ));
    } on DioException catch (e) {
      print("Error en getBonoCafeteria $e");
      return left(e);
    }
  }

  Future<Either<DioException, String>> validarBono(
      String accessToken, int idBono) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );

    try {
      final response =
          await dio.put("$urlApiGetHistorialBono/$idBono", options: options);
      print(response);
      if (response.statusCode == 200) {;
        return right(response.data["message"]);
      }

      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.data["error"],
      ));
    } on DioException catch (e) {
      print("Error en validarBono $e");
      return left(e);
    }
  }


  Future<Either<DioException, String>> updateBono(String accessToken, BonoModel bono) async {

    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
      
    );
    
    print(bono);
    try {
      final response = await dio.put("$urlApiGetBonosCafeteria/${bono.id!}", options: options, data: bono.toJson());
      if (response.statusCode == 200) {
        return right(
          response.data["message"],
        );
      }
      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.data["error"],
      ));
    } on DioException catch (e) {
      print("Error en onUpdateBono $e");
      return left(e);
    }
  }
}
