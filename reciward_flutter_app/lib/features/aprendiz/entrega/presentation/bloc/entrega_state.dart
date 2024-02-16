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

///historial entregas
final class HistorialInitial extends EntregaState {}

final class HistorialEntregaLoading extends EntregaState {}

final class HistorialEntregaFailed extends EntregaState {
  final String error;
  HistorialEntregaFailed({required this.error});
}

final class HistorialEntregaSuccess extends EntregaState {
  final List<HistorialEntity> entregas;

  HistorialEntregaSuccess({required this.entregas});
}

//cafeteria

final class GetEntregaCafeteriaSuccess extends EntregaState {
  final GetEntregaCafeteriaDto data;

  GetEntregaCafeteriaSuccess({required this.data});
}

final class GetEntregaCafeteriaFailed extends EntregaState {
  final String error;

  GetEntregaCafeteriaFailed({required this.error});
}



final class ValidarEntregaSuccess extends EntregaState {
  final String message;

  ValidarEntregaSuccess({
    required this.message
  });
}

final class ValidarEntregaFailed extends EntregaState {
  final String error;

  ValidarEntregaFailed({
    required this.error
  });
}



