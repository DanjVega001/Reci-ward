part of 'punto_bloc.dart';

sealed class PuntoState {}

final class PuntoInitial extends PuntoState {}

final class GetPuntosFailedState extends PuntoState {
  final String error;

  GetPuntosFailedState({
    required this.error
  });
}

final class GetPuntosSuccessState extends PuntoState {
  final GetPuntoDto getPuntoDto;

  GetPuntosSuccessState({
    required this.getPuntoDto
  });
}


final class GetPutosLoadingState extends PuntoState {}