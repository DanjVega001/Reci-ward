class GetPuntoDto {
  final String? id;
  final int? cantidadAcumulada;
  final int? puntosUtilizados;
  final String? aprendizId;

  const GetPuntoDto(
      {this.id,
      this.cantidadAcumulada,
      this.puntosUtilizados,
      this.aprendizId});

  factory GetPuntoDto.fromJson(Map<String, dynamic> json) {
    return GetPuntoDto(
        id: json["id"].toString(),
        cantidadAcumulada: int.parse(json["cantidadAcumulada"]),
        puntosUtilizados: int.parse(json["puntosUtilizados"]),
        aprendizId: json["aprendiz_id"].toString());
  }
}
