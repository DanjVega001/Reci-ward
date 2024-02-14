class GetHistorialBono {
  final String ? id;
  final int ? codigoValidante;
  final bool ? estadoBono;
  final String ? fechaVencimiento;

  const GetHistorialBono({
    required this.codigoValidante,
    required this.estadoBono,
    required this.fechaVencimiento,
    required this.id,
  });

  factory GetHistorialBono.fromJson(Map<String, dynamic> json) {
    return GetHistorialBono(
      codigoValidante: json['codigoValidante'],
      estadoBono: json['estadoBono'],
      fechaVencimiento: "${json['fechaVencimiento']}",
      id: json['id'].toString(),
    );
  }
}