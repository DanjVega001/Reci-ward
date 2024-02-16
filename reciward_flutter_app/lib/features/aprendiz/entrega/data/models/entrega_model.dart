import 'package:reciward_flutter_app/features/aprendiz/entrega/data/models/get_entrega_material_model.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/entrega_entity.dart';

class EntregaModel {
  final String ? id;
  final int ? cantidadMaterial;
  final bool ? canjeada;
  final int ? puntosAcumulados;
  final String ? cafeteriaId;
  final String ? aprendizId;
  final List<GetEntregaMaterialModel> ? materiales;

  const EntregaModel({
    this.id,
    this.cantidadMaterial,
    this.puntosAcumulados,
    this.canjeada,
    this.aprendizId,
    this.cafeteriaId,
    this.materiales
  });

  factory EntregaModel.fromJson(Map<String, dynamic> json){
    return EntregaModel(
      id: json["id"].toString(),
      cantidadMaterial: json["cantidadMaterial"],
      canjeada: json["canjeada"]==1 ? true : false,
      puntosAcumulados: json["puntosAcumulados"],
      aprendizId: json["aprendiz_id"].toString(),
      materiales: (json["materiales"] as List).map((e) => GetEntregaMaterialModel.fromJson(e)).toList()
    );
  }

  EntregaEntity toEntity () {
    return EntregaEntity(
      id: id,
      cantidadMaterial: cantidadMaterial,
      canjeada: canjeada,
      puntosAcumulados: puntosAcumulados,
      aprendizId: aprendizId,
      materiales: materiales!.map((e) => e.toEntity()).toList()
    );
  }
}