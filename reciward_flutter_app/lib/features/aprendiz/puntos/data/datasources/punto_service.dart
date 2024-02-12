import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';

class PuntoService {
  late Dio dio;

  PuntoService() {
    dio = Dio();
  }

  Future<Either<DioException, GetPuntoDto>> getPuntos(
      String accessToken) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );

    try {
      final response = await dio.get(urlApiGetPuntos, options: options);
      if (response.statusCode == 200) {
        return right(GetPuntoDto.fromJson(response.data));
      }
      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
      ));
    } on DioException catch (e) {
      print("Error en getPuntos Service class ${e.message}");
      return left(e);
    }
  }
}
