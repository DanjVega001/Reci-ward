class SaveEntregaDto {
  final int puntosAcumulados;
  final int cantidadMaterial;
  final List<String> materialesId;

  const SaveEntregaDto({
    required this.cantidadMaterial,
    required this.materialesId,
    required this.puntosAcumulados
  });


  Map<String, dynamic> toJson(){
    return {
      "puntosAcumulados" : puntosAcumulados,
      "cantidadMaterial" : cantidadMaterial,
      "materiales" : materialesId.map((e) => int.parse(e)).toList()
    };
  }

}