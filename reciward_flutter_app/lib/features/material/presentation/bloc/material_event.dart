part of 'material_bloc.dart';

sealed class MaterialEvent extends Equatable {
  const MaterialEvent();

  @override
  List<Object> get props => [];
}


class GetMaterialesEvent extends MaterialEvent {
  final String accessToken;
  final String rol;

  const GetMaterialesEvent({required this.accessToken, required this.rol});    
}
