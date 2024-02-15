class SaveEntregaDto {
  final int puntosAcumulados;
  final int cantidadMaterial;
  final List<Map<String, int>> materiales;

  const SaveEntregaDto(
      {required this.cantidadMaterial,
      required this.materiales,
      required this.puntosAcumulados});

  Map<String, dynamic> toJson() {
    return {
      "puntosAcumulados": puntosAcumulados,
      "cantidadMaterial": cantidadMaterial,
      "materiales": materiales
    };
  }
}
