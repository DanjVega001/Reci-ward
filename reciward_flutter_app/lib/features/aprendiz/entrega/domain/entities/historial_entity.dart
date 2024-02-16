class HistorialEntity {
  final String? id;
  final int? cantidadMaterial;
  final bool? canjeada;
  final int? puntosAcumulados;
  final String? nombreMaterial;

  HistorialEntity(
      {required this.id,
      required this.cantidadMaterial,
      required this.canjeada,
      required this.puntosAcumulados,
      required this.nombreMaterial});
}
