class GetBonoCafeteriaDto {
  final String ? id;
  final String ? nombreAprendiz;
  final String ? apellidoAprendiz;
  final int ? documento;
  final String ? fechaVencimiento;
  final int ? valorBono;

  const GetBonoCafeteriaDto({
    this.id,
    this.nombreAprendiz,
    this.apellidoAprendiz,
    this.documento,
    this.fechaVencimiento,
    this.valorBono
  });

  factory GetBonoCafeteriaDto.fromJson(Map<String, dynamic> json){
    return GetBonoCafeteriaDto(
      id: json['id'].toString(),
      nombreAprendiz: json['nombreAprendiz'],
      apellidoAprendiz: json['apellidoAprendiz'],
      documento: json['documento'],
      fechaVencimiento: json['fechaVencimiento'],
      valorBono: json['valorBono']
    );
  }
}