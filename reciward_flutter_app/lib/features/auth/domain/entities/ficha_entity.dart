import 'package:equatable/equatable.dart';

class FichaEntity extends Equatable{
  final String ? id;
  final String ? nombreFicha;
  final int ? numeroFicha;

  const FichaEntity({ this.id, this.nombreFicha, this.numeroFicha});
  
  @override
  List<Object?> get props => [id, nombreFicha, numeroFicha];
}