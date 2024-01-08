// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';

class AprendizEntity extends Equatable {
  final String ? id;
  final String ? tipoDocumento;
  final int ? numeroDocumento;
  final String ? descripcionPerfil;
  final String ? avatar;
  final String ? apellido;
  final FichaEntity ? ficha;

  const AprendizEntity(
      {this.id,
      this.tipoDocumento,
      this.numeroDocumento,
      this.apellido,
      this.avatar,
      this.descripcionPerfil, 
      required this.ficha
      });
      
  @override
  List<Object?> get props => [];
  

  @override
  bool get stringify => true;
}
