
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/core/exceptions/exceptions.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/save_entrega_usecase.dart';

part 'entrega_event.dart';
part 'entrega_state.dart';

class EntregaBloc extends Bloc<EntregaEvent, EntregaState> {

  SaveEntregaUsecase usecase = GetIt.instance<SaveEntregaUsecase>();

  EntregaBloc() : super(EntregaInitial()) {
    on<SaveEntregaEvent>(onSaveEntregaEvent);
  }

  void onSaveEntregaEvent(SaveEntregaEvent event, Emitter<EntregaState> emit) async {
    try {

      final validate = event.validate();
      if (validate!=null) {
        return emit(SaveEntregaFailed(error: validate.getErrorMessage()));
      }

      emit(SaveEntregaLoading());

      Either<DioException, String> either = await usecase.call(event.accessToken, event.saveEntregaDto);

      return either.fold((dioException) {
        emit(SaveEntregaFailed(error: dioException.message!));
      }, 
      (message) {
        emit(SaveEntregaSuccess(message: message));
      });
    } catch (e) {
      print("Error en onSaveEntregaEvent ${e.toString()}");
      return emit(SaveEntregaFailed(error: e.toString()));
    }
  }
}
