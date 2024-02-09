part of 'entrega_bloc.dart';

sealed class EntregaState {}

final class EntregaInitial extends EntregaState {}

final class SaveEntregaSuccess extends EntregaState {
  final String message;

  SaveEntregaSuccess({required this.message});
}

final class SaveEntregaFailed extends EntregaState {
  final String error;

  SaveEntregaFailed({required this.error});
}

final class SaveEntregaLoading extends EntregaState {}