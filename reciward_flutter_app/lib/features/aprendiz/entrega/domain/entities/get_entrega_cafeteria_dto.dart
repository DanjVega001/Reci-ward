import 'package:reciward_flutter_app/features/aprendiz/entrega/data/models/entrega_model.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/entrega_entity.dart';

class GetEntregaCafeteriaDto {
  final int ? documento;
  final String ? nombre;
  final String ? apellido;
  final EntregaEntity ? entrega;

  const GetEntregaCafeteriaDto({
    this.apellido,
    this.documento,
    this.nombre,
    this.entrega
  });

  factory GetEntregaCafeteriaDto.fromJson(Map<String, dynamic> json){
    return GetEntregaCafeteriaDto(  
      documento: json["documento"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      entrega: EntregaModel.fromJson(json["entrega"]).toEntity()
    );
  }
}