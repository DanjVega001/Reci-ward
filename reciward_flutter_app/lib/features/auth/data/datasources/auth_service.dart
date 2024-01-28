// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reciward_flutter_app/core/constants/urls_apis.dart';
import 'package:reciward_flutter_app/features/auth/data/models/ficha_model.dart';
import 'package:reciward_flutter_app/features/auth/data/models/user_model.dart';

class AuthService {
  late Dio dio;

  AuthService() {
    dio = Dio();
  }

  Future<Either<DioException, String>> signup(UserModel aprendiz) async {
    try {
      final response = await dio.post(urlApiAuthSignup,
          data: aprendiz.toJson(),
          options: Options(
              contentType: 'application/json',
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode == 201) {
        return right(response.data['message']);
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

  Future<Either<DioException, UserModel>> login(UserModel user) async {
    try {
      final response = await dio.post(urlApiAuthLogin,
          data: user,
          options: Options(
            followRedirects: false,
            contentType: 'application/json',
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        return right(userModel);
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

  Future<Either<DioException, String>> logout(String accessToken) async {
    Options options =
        Options(headers: {'Authorization': 'Bearer $accessToken'});
    try {
      final response = await dio.post(urlApiAuthLogout, options: options);
      if (response.statusCode == 200) {
        return right(response.data['message']);
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

  Future<Either<DioException, List<FichaModel>>> getFichas() async {
    try {
      final response = await dio.get(urlApiGetFichas);
      if (response.statusCode == 200) {
        final results = response.data;
        final fichas =
            (results as List).map((e) => FichaModel.fromJson(e)).toList();
        return right(fichas);
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

  Future<Either<DioException, String>> sendMailResetPassword(
      String email) async {
    try {
      Options options = Options(
        contentType: 'application/json',
        validateStatus: (status) {
          return status! < 500;
        },
      );
      Map<String, dynamic> data = {"email": email};
      final response = await dio.post(urlApiSendMailResetPassword,
          data: data, options: options);
      if (response.statusCode == 200) return right(response.data["message"]);
      return left(DioException(
          requestOptions: response.requestOptions,
          message: response.statusMessage));
    } on DioException catch (e) {
      return left(e);
    }
  }

  Future<Either<DioException, String>> resetPassword(
      String password, String token) async {
    try {
      Options options = Options(
        contentType: 'application/json',
        validateStatus: (status) {
          return status! < 500;
        },
      );
      Map<String, dynamic> data = {"password": password, "token": token};
      final response =
          await dio.post(urlApiResetPassword, data: data, options: options);
      if (response.statusCode == 200) return right(response.data["message"]);
      return left(DioException(
          requestOptions: response.requestOptions,
          message: response.statusMessage));
    } on DioException catch (e) {
      return left(e);
    }
  }
}
