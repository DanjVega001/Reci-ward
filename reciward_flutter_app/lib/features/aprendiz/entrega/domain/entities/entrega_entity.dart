import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_material_entity.dart';

class EntregaEntity {
  final String ? id;
  final int ? cantidadMaterial;
  final bool ? canjeada;
  final int ? puntosAcumulados;
  final String ? cafeteriaId;
  final String ? aprendizId;
  final List<GetEntregaMaterialEntity> ? materiales;

  const EntregaEntity({
    this.id,
    this.cantidadMaterial,
    this.puntosAcumulados,
    this.canjeada,
    this.aprendizId,
    this.cafeteriaId,
    this.materiales
  });
}