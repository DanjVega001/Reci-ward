class GetHistorialBono {
  final String? id;
  final String? codigoValidante;
  final bool? estadoBono;
  final DateTime? fechaVencimiento;
  late Duration remainingTime;
  bool isActive; // Nuevo campo

  GetHistorialBono({
    required this.codigoValidante,
    required this.estadoBono,
    required this.fechaVencimiento,
    required this.id,
  })  : isActive = estadoBono == true,
        remainingTime = Duration.zero {
    calculateRemainingTime();
  }

  factory GetHistorialBono.fromJson(Map<String, dynamic> json) {
    return GetHistorialBono(
      codigoValidante: json['codigoValidante'],
      estadoBono: json['estadoBono'] == 0 ? true : false,
      fechaVencimiento: DateTime.parse("${json['fechaVencimiento']}"),
      id: json['id'].toString(),
    );
  }

  void calculateRemainingTime() {
    if (isActive) {
      remainingTime = fechaVencimiento!.difference(DateTime.now());
    } else {
      remainingTime = Duration.zero;
    }
  }
}
