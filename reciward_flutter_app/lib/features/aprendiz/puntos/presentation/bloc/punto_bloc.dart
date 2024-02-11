import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/entities/get_puntos_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/puntos/domain/usecases/get_puntos_usecase.dart';

part 'punto_event.dart';
part 'punto_state.dart';

class PuntoBloc extends Bloc<PuntoEvent, PuntoState> {
  GetPuntosUsecase usecase = GetIt.instance<GetPuntosUsecase>();

  PuntoBloc() : super(PuntoInitial()) {
    on<GetPuntosEvent>(onGetPuntosEvent);
  }

  void onGetPuntosEvent(GetPuntosEvent event, Emitter<PuntoState> emit) async {
    try {
      Either<DioException, GetPuntoDto> either =
          await usecase.call(event.accessToken);
      return either.fold(
          (dioException) =>
              emit(GetPuntosFailedState(error: dioException.message!)),
          (data) => emit(GetPuntosSuccessState(getPuntoDto: data)));
    } catch (e) {
      print("Error en onGetPuntosEvent ${e.toString()}");
      return emit(GetPuntosFailedState(error: e.toString()));
    }
  }
}
