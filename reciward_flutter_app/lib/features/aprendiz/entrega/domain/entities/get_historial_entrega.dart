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
    // print(json["nombreMaterial"]);
    return GetHistorialEntrega(
      cantidadMaterial: json['cantidadMaterial'],
      canjeada: json['canjeada'] == 0 ? true : false,
      puntosAcumulados: json['puntosAcumulados'],
      nombreMaterial:
          (json['nombreMaterial'] as List).map((e) => e.toString()).toList(),
      id: json['id'].toString(),
    );
  }
}
