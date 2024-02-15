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
