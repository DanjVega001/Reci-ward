part of 'material_bloc.dart';

sealed class MaterialesState extends Equatable {
  const MaterialesState();
  
  @override
  List<Object> get props => [];
}

final class MaterialInitial extends MaterialesState {}

final class GetMaterialLoading extends MaterialesState {}

final class GetMaterialSuccess extends MaterialesState {
  final List<MaterialEntity> materiales;

  const GetMaterialSuccess({required this.materiales});

}

final class GetMaterialFailed extends MaterialesState {
  final String error;

  const GetMaterialFailed({required this.error});
}
