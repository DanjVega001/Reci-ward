
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';

class MaterialModel {

  final String ? id;
  final String ? nombreMaterial;
  final int ? numeroPuntos;
  final String ? clasificacion;


  const MaterialModel({this.id, this.clasificacion, this.nombreMaterial, this.numeroPuntos});

  factory MaterialModel.fromJson(Map<String, dynamic> json){
    return MaterialModel(
      id: json['id'].toString(),
      nombreMaterial: json['nombreMaterial'],
      numeroPuntos: json['numeroPuntos'],
      clasificacion: json['clasificacion']
    );
  }

  MaterialEntity toEntity(){
    return MaterialEntity(
      clasificacion: clasificacion,
      id: id,
      nombreMaterial: nombreMaterial,
      numeroPuntos: numeroPuntos
    );
  }
}