import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_material_entity.dart';

class GetEntregaMaterialModel {
  final String ? nombreMaterial;
  final int ? numeroPuntos;
  final int ? numeroMaterial;

  const GetEntregaMaterialModel({
    this.nombreMaterial,
    this.numeroPuntos,
    this.numeroMaterial
  }); 

  factory GetEntregaMaterialModel.fromJson(Map<String, dynamic> json){
    return GetEntregaMaterialModel(
      nombreMaterial: json["nombreMaterial"],
      numeroPuntos: int.parse(json["numeroPuntos"]),
      numeroMaterial: int.parse(json["numeroMaterial"])
    );
  }

  GetEntregaMaterialEntity toEntity(){
    return GetEntregaMaterialEntity(
      nombreMaterial: nombreMaterial,
      numeroMaterial: numeroMaterial,
      numeroPuntos: numeroPuntos
    );
  }
}