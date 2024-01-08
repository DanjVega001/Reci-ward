// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:equatable/equatable.dart';

import 'package:reciward_flutter_app/features/auth/data/models/ficha_model.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/aprendiz_entity.dart';

class AprendizModel extends Equatable {
  final String ? id;
  final String ? tipoDocumento;
  final int ? numeroDocumento;
  final String ? descripcionPerfil;
  final String ? avatar;
  final String ? apellido;
  final FichaModel ? ficha;

  const AprendizModel({
    this.id,
    this.tipoDocumento,
    this.numeroDocumento,
    this.apellido,
    this.avatar,
    this.descripcionPerfil,
    this.ficha
  });

  factory AprendizModel.fromJson(Map<String, dynamic> json){
    Map<String, dynamic> aprendiz = json['aprendiz'];
    Map<String, dynamic> perfil = json['perfil'];
    Map<String, dynamic> ficha = json['ficha'];


    return AprendizModel(
      id: aprendiz['id'].toString(),
      tipoDocumento: aprendiz['tipoDocumento'],
      numeroDocumento: aprendiz['numeroDocumento'],
      apellido: perfil['apellido'],
      descripcionPerfil: perfil['descripcionPerfil'],
      avatar: perfil['avatar'],
      ficha: FichaModel.fromJson(ficha)
    );
  }
  
  factory AprendizModel.fromAprendizEntity(AprendizEntity ? aprendizEntity){
    return AprendizModel(
      id: aprendizEntity?.id,
      apellido: aprendizEntity?.apellido,
      numeroDocumento: aprendizEntity?.numeroDocumento,
      tipoDocumento: aprendizEntity?.tipoDocumento,
      ficha: FichaModel.fromFichaEntity(aprendizEntity?.ficha)
    );
  }
  
  AprendizEntity toEntity(){
    return AprendizEntity(
      id: id,
      numeroDocumento: numeroDocumento,
      tipoDocumento: tipoDocumento,
      apellido: apellido,
      avatar: avatar,
      descripcionPerfil: descripcionPerfil,
      ficha: ficha?.toEntity()
    );
  }

  @override
  List<Object?> get props => [id, ];  

  @override
  bool get stringify => true;
}
