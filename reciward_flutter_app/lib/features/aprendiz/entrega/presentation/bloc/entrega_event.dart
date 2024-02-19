part of 'entrega_bloc.dart';

sealed class EntregaEvent {}

class SaveEntregaEvent extends EntregaEvent {
  final String accessToken;
  final SaveEntregaDto saveEntregaDto;

  SaveEntregaEvent({required this.accessToken, required this.saveEntregaDto});

  GlobalException? validate() {
    if (accessToken.trim().isEmpty) {
      return GlobalException(errorMessage: "User Unathenticated");
    }
    if (saveEntregaDto.cantidadMaterial <= 0 ||
        saveEntregaDto.cantidadMaterial <= 0) {
      return GlobalException(errorMessage: "You must choose some material");
    }
    return null;
  }
}

class HistorialEntrega extends EntregaEvent {
  final String accessToken;

  HistorialEntrega({
    required this.accessToken,
  });

  GlobalException? validate() {
    if (accessToken.trim().isEmpty) {
      return GlobalException(errorMessage: "User Unathenticated");
    }
    return null;
  }
}

class GetEntregaCafeteriaEvent extends EntregaEvent {
  final String accessToken;
  final int idEntrega;

  GetEntregaCafeteriaEvent(
      {required this.accessToken, required this.idEntrega});

  GlobalException? validate() {
    if (accessToken.trim().isEmpty) {
      return GlobalException(errorMessage: "User Unathenticated");
    }

    if (idEntrega <= 0) {
      return GlobalException(errorMessage: "Busque una entrega por su codigo");
    }

    return null;
  }
}

class ValidarEntregaEvent extends EntregaEvent {
  final String accessToken;
  final int idEntrega;

  ValidarEntregaEvent({
    required this.idEntrega,
    required this.accessToken,
  }); 

}
