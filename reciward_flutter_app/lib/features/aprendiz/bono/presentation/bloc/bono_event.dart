part of 'bono_bloc.dart';

sealed class BonoEvent {}

class GetBonosEvent extends BonoEvent {
  final String accessToken;
  final String rol;

  GetBonosEvent({
    required this.accessToken,
    required this.rol
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


class GetBonoCafeteriaEvent extends BonoEvent {
  final String accessToken;
  final String code;

  GetBonoCafeteriaEvent({
    required this.accessToken,
    required this.code
  });
}

class ValidarBonoEvent extends BonoEvent {
  final String accessToken;
  final int idBono;

  ValidarBonoEvent({
    required this.accessToken,
    required this.idBono
  });
}

class UpdateBonoEvent extends BonoEvent {
  final String accessToken;
  final BonoEntity bonoEntity;

  UpdateBonoEvent({
    required this.accessToken,
    required this.bonoEntity,
  });
}
