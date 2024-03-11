class GetHistorialEntrega {
  final String? id;
  final int? cantidadMaterial;
  final bool? canjeada;
  final int? puntosAcumulados;
  final List<String>? nombreMaterial;

  GetHistorialEntrega({
    required this.cantidadMaterial,
    required this.canjeada,
    required this.puntosAcumulados,
    required this.nombreMaterial,
    required this.id,
  });

  factory GetHistorialEntrega.fromJson(Map<String, dynamic> json) {
    print(json["canjeada"]);
    return GetHistorialEntrega(
      cantidadMaterial: int.parse(json['cantidadMaterial']),
      canjeada: int.parse(json['canjeada']) == 0 ? true : false,
      puntosAcumulados: int.parse(json['puntosAcumulados']),
      nombreMaterial: (json['nombreMaterial'] as String).split(', '),
      id: json['id'].toString(),
    );
  }
}
