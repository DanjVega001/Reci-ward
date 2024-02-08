part of 'tip_bloc.dart';

sealed class TipState {}

final class TipInitial extends TipState {}

final class TipLoading extends TipState {}

final class GetTipSuccess extends TipState {
  final List<TipEntity> datos;

  GetTipSuccess({required this.datos});
}

final class GetTipFailure extends TipState {
  final String error;
  GetTipFailure({required this.error});
}
