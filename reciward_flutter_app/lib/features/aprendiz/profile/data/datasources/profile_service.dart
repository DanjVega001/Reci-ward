import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/features/aprendiz/profile/domain/entities/update_user_data_dto.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';

class ProfileService {
  late Dio dio;

  ProfileService() {
    dio = Dio();
  }

  Future<Either<DioException, String>> updateUser(
      String accessToken, UpdatedUserData userData) async {
    try {
      Options options = Options(
        headers: {'Authorization': 'Bearer $accessToken'},
        contentType: 'application/json',
        validateStatus: (status) {
          return status! < 500;
        },
      );
      final response = await dio.put(
        urlApiUpdateUser,
        data: userData.toJson(),
        options: options,
      );
      if (response.statusCode == 200) {
        return right(response.data['message']);
      } else {
        return left(DioException(
          requestOptions: response.requestOptions,
          message: response.statusMessage,
        ));
      }
    } on DioException catch (e) {
      print("error en getFichas: $e");
      return left(e);
    }
  }
}
