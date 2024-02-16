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

  factory HistorialEntity.fromJson(Map<String, dynamic> json) {
    return HistorialEntity(
      cantidadMaterial: json['cantidadMaterial'],
      canjeada: json['canjeada'] == 0 ? true : false,
      puntosAcumulados: json['puntosAcumulados'],
      nombreMaterial: json['nombreMaterial'],
      id: json['id'].toString(),
    );
  }
}
