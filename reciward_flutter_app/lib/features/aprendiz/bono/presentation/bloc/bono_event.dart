part of 'bono_bloc.dart';

sealed class BonoEvent {}

class GetBonosEvent extends BonoEvent {
  final String accessToken;

  GetBonosEvent({
    required this.accessToken
  });
}

class SaveBonoAprendizEvent extends BonoEvent {
  final int bonoId;
  final String accessToken;

  SaveBonoAprendizEvent({
    required this.bonoId,
    required this.accessToken
  });
}

class GetHistorialBonosEvent extends BonoEvent {
  final String accessToken;

  GetHistorialBonosEvent({
    required this.accessToken
  });
    
}
