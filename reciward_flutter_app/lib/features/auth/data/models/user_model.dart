// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:reciward_flutter_app/features/auth/data/models/aprendiz_model.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/aprendiz_entity.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String? id;
  final String? name;
  final String email;
  final String? password;
  final String? accces_token;
  final AprendizModel? aprendizModel;
  final String? rol;

  const UserModel(
      {this.id,
      this.name,
      required this.email,
      required this.password,
      this.aprendizModel,
      this.accces_token,
      this.rol
    });

  factory UserModel.fromJson(Map<String, dynamic> json) {

    print(json['rol']);
    return UserModel(
        email: json['email'],
        id: json['id'].toString(),
        name: json['name'],
        password: json['password'],
        accces_token: json['access_token'],
        rol: json['rol'][0],
        aprendizModel: json['rol'][0] == "aprendiz" ? AprendizModel.fromJson(json) : null);
  }

  factory UserModel.fromUserEntity(UserEntity entity) {
    AprendizEntity? aprendizEntity = entity.aprendizEntity;
    return UserModel(
        email: entity.email,
        id: entity.id,
        name: entity.name,
        password: entity.password,
        rol: entity.rol,
        aprendizModel: AprendizModel.fromAprendizEntity(aprendizEntity),
        accces_token: entity.accces_token);
  }

  UserEntity toEntity() {
    return UserEntity(
        email: email,
        id: id,
        name: name,
        accces_token: accces_token,
        password: password,
        rol: rol,
        aprendizEntity: aprendizModel?.toEntity());
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "apellido": aprendizModel!.apellido,
      "email": email,
      "password": password,
      "numeroDocumento": aprendizModel!.numeroDocumento,
      "tipoDocumento": aprendizModel!.tipoDocumento,
      "ficha_id": aprendizModel!.ficha?.id
    };
  }

  @override
  List<Object?> get props => [id, name, email, password];
}
