import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';

class BonoModel {
  
  final String ? id;
  final int ? valorBono;
  final int ? puntosRequeridos;

  const BonoModel({
    this.id,
    this.puntosRequeridos,
    this.valorBono
  });

  factory BonoModel.fromJson(Map<String, dynamic> json){
    return BonoModel(
      id: json['id'].toString(),
      valorBono: json['valorBono'],
      puntosRequeridos: json['puntosRequeridos']
    );
  }

  BonoEntity toEntity(){
    return BonoEntity(
      id: id,
      puntosRequeridos: puntosRequeridos,
      valorBono: valorBono
    );
  }
}