part of 'punto_bloc.dart';

sealed class PuntoEvent {}

class GetPuntosEvent extends PuntoEvent {
  final String accessToken;

  GetPuntosEvent({
    required this.accessToken
  });
}
