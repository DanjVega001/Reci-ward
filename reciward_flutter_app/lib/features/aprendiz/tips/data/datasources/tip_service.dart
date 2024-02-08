import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/data/models/tip_model.dart';

class TipService {
  late Dio dio;

  TipService() {
    dio = Dio();
  }

  Future<Either<DioException, List<TipModel>>> getTips(
      String accessToken) async {
    Options options = Options(
      headers: {'Authorization': 'Bearer $accessToken'},
      contentType: 'application/json',
      validateStatus: (status) {
        return status! < 500;
      },
    );
    try {
      final response = await dio.get(urlApiGetTips, options: options);
      print(response);
      if (response.statusCode == 200) {
        final results = response.data;
        final fichas =
            (results as List).map((e) => TipModel.fromJson(e)).toList();
        return right(fichas);
      } else {
        return left(DioException(
          requestOptions: response.requestOptions,
          message: response.statusMessage,
        ));
      }
    } on DioException catch (e) {
      print(e);
      return left(e);
    }
  }
}
