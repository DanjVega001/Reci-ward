// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'package:reciward_flutter_app/features/auth/domain/entities/aprendiz_entity.dart';

class UserEntity extends Equatable {
  final String ? id;
  final String ? name;
  final String email;
  final String ? password;
  final AprendizEntity ? aprendizEntity;
  final String ? accces_token;

  const UserEntity(
      {this.id,
      this.name,
      required this.email,
      this.password,
      this.aprendizEntity,
      this.accces_token
      });



  @override
  List<Object?> get props => [id, name, email, password, aprendizEntity];

  

  @override
  bool get stringify => true;
}
