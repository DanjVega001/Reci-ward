// ignore_for_file: public_member_api_docs, sort_constructors_first,, implementation_imports 
import 'package:dartz/dartz.dart';
import 'package:dio/src/dio_exception.dart';
import 'package:reciward_flutter_app/features/auth/data/datasources/auth_service.dart';
import 'package:reciward_flutter_app/features/auth/data/models/user_model.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {

  late AuthService service;

  AuthRepositoryImpl({
    required this.service,
  });

  @override
  Future<Either<DioException, UserEntity>> login(UserEntity user) async {
    try {
      UserModel userModel = UserModel.fromUserEntity(user);
      final either = await service.login(userModel);
      
      return either.fold(
        (dioException) => left(dioException),
        (userModel) => right(userModel.toEntity()),
      );
    } on DioException catch (e) {
      print(e);
      return left(e);
    }
  }

  @override
  Future<Either<DioException, String>> logout(String accessToken) async {
    return await service.logout(accessToken);
  }

  @override
  Future<Either<DioException, String>> signup(UserEntity aprendiz) async {    
    UserModel aprendizModel=  UserModel.fromUserEntity(aprendiz);
    return await service.signup(aprendizModel);
  }

  @override
  Future<Either<DioException, List<FichaEntity>>> getFichas() async {
    try {
      final fichasModels = await service.getFichas();

      return fichasModels.fold(
        (dioException) => left(dioException), 
        (fichas) => right(fichas.map((e) => e.toEntity()).toList()) 
      );

    } catch (e) {
      rethrow;
    }
  }

  

}
