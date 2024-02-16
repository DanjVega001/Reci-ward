import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_cafeteria_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';

class EntregaService {
  late Dio dio;

  EntregaService() {
    dio = Dio();
  }

  Future<Either<DioException, String>> saveEntrega(
      String accessToken, SaveEntregaDto saveEntregaDto) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );

    try {
      final response = await dio.post(urlApiSaveEntrega,
          options: options, data: saveEntregaDto.toJson());

      if (response.statusCode == 201) {
        return right(response.data['message']);
      }
      return left(DioException(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
      ));
    } on DioException catch (e) {
      print("Errror en saveEntrega ${e.message}");
      return left(e);
    }
  }


  Future<Either<DioException, GetEntregaCafeteriaDto>> getEntregaCafeteria(String accessToken, int idEntrega) async {
    
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );
    
    try {
      final response = await dio.get("$urlApiSaveEntrega/$idEntrega", options: options);
      if (response.statusCode == 200) {
        return right(GetEntregaCafeteriaDto.fromJson(response.data));
      }
        
       return left(DioException(
        requestOptions: response.requestOptions,
        message: response.statusMessage,
      ));
    } on DioException catch (e) {
      print("Errror en getEntregaCafeteria ${e.message}");
      return left(e);
    }
  }
}
