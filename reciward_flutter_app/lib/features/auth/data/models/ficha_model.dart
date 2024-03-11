import 'package:equatable/equatable.dart';
import 'package:reciward_flutter_app/features/auth/domain/entities/ficha_entity.dart';

class FichaModel extends Equatable{
  final String ? id;
  final String ? nombreFicha;
  final int ? numeroFicha;

  const FichaModel({ this.id, this.nombreFicha, this.numeroFicha});
  
  FichaEntity toEntity() {
    final ficha = FichaEntity(
      id: id,
      nombreFicha: nombreFicha,
      numeroFicha: numeroFicha
    );
    return ficha;
  }

  factory FichaModel.fromJson(Map<String, dynamic> json){
    return FichaModel(
      id: json['id']?.toString(),
      nombreFicha: json['nombreFicha'],
      numeroFicha: int.parse(json['codigoFicha'])
    );
  }

  factory FichaModel.fromFichaEntity(FichaEntity ? fichaEntity){
    return FichaModel(
      id : fichaEntity?.id,
      nombreFicha: fichaEntity?.nombreFicha,
      numeroFicha: fichaEntity?.numeroFicha
    );
  }


  @override
  List<Object?> get props => [id, nombreFicha, numeroFicha];
}