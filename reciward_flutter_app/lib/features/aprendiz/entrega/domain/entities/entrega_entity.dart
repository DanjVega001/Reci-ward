class EntregaEntity {
  final String? id;
  final int? cantidadMaterial;
  final bool? canjeada;
  final int? puntosAcumulados;
  final String? cafeteriaId;
  final String? aprendizId;

  const EntregaEntity(
      {this.id,
      this.cantidadMaterial,
      this.puntosAcumulados,
      this.canjeada,
      this.aprendizId,
      this.cafeteriaId});
}
