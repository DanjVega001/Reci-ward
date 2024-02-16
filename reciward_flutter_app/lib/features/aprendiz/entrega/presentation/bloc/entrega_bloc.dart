import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/core/exceptions/exceptions.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/historial_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/historial_entrega_usecase.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/get_entrega_cafeteria_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/entities/save_entrega_dto.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/get_entrega_cafeteria_usecase.dart';

import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/save_entrega_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/entrega/domain/usecases/validar_entrega_usecase.dart';

part 'entrega_event.dart';
part 'entrega_state.dart';

class EntregaBloc extends Bloc<EntregaEvent, EntregaState> {
  SaveEntregaUsecase usecase = GetIt.instance<SaveEntregaUsecase>();

  HistorialEntregaUsecase usecase2 = GetIt.instance<HistorialEntregaUsecase>();
  
  GetEntregaCafeteriaUsecase getEntregaCafeteriaUsecase = GetIt.instance<GetEntregaCafeteriaUsecase>();

  

  ValidarEntregaUsecase validarEntregaUsecase = GetIt.instance<ValidarEntregaUsecase>();

  EntregaBloc() : super(EntregaInitial()) {
    on<SaveEntregaEvent>(onSaveEntregaEvent);
    on<HistorialEntrega>(onHistorialEntrega);
    on<GetEntregaCafeteriaEvent>(onGetEntregaCafeteriaEvent);


    on<ValidarEntregaEvent>(onValidarEntregaEvent);
  }

  void onGetEntregaCafeteriaEvent (GetEntregaCafeteriaEvent event, Emitter<EntregaState> emit) async {
    try {
      final validate = event.validate();
      if (validate!=null) {
        return emit(GetEntregaCafeteriaFailed(error: validate.getErrorMessage()));
      }

      Either<DioException, GetEntregaCafeteriaDto> either = await getEntregaCafeteriaUsecase.call(event.accessToken, event.idEntrega);

      return either.fold((dioException) {
        emit(GetEntregaCafeteriaFailed(error: dioException.message!));
      }, 
      (data) {
        emit(GetEntregaCafeteriaSuccess(data: data));
      });

    } catch (e) {
      print("Error en onGetEntregaCafeteriaEvent ${e.toString()}");
      return emit(GetEntregaCafeteriaFailed(error: e.toString()));
    }

  }

  void onSaveEntregaEvent(
      SaveEntregaEvent event, Emitter<EntregaState> emit) async {
    try {
      final validate = event.validate();
      if (validate != null) {
        return emit(SaveEntregaFailed(error: validate.getErrorMessage()));
      }

      emit(SaveEntregaLoading());

      Either<DioException, String> either =
          await usecase.call(event.accessToken, event.saveEntregaDto);

      return either.fold((dioException) {
        emit(SaveEntregaFailed(error: dioException.message!));
      }, (message) {
        emit(SaveEntregaSuccess(message: message));
      });
    } catch (e) {
      print("Error en onSaveEntregaEvent ${e.toString()}");
      return emit(SaveEntregaFailed(error: e.toString()));
    }
  }





































  void onValidarEntregaEvent (ValidarEntregaEvent event, Emitter<EntregaState> emit) async {
    try {
      Either<DioException, String> either = await validarEntregaUsecase.call(event.accessToken, event.idEntrega);

      return either.fold(
      (dio) => emit(ValidarEntregaFailed(error: dio.message!)), 
      (message) => emit(ValidarEntregaSuccess(message: message)));
    } catch (e) {
      print("Error en onValidarEntregaUsecase ${e.toString()}");
      return emit(ValidarEntregaFailed(error: e.toString()));
    }
  }



  void onHistorialEntrega(
      HistorialEntrega event, Emitter<EntregaState> emit) async {
    try {
      final validate = event.validate();
      if (validate != null) {
        return emit(HistorialEntregaFailed(error: validate.getErrorMessage()));
      }

      emit(HistorialEntregaLoading());

      Either<DioException, String> either =
          await usecase2.call(event.accessToken, event.historialEntity);

      return either.fold((dioException) {
        emit(HistorialEntregaFailed(error: dioException.message!));
      }, (message) {
        emit(HistorialEntregaSuccess(message: message));
      });
    } catch (e) {
      print("Error en onHistorialEntrega ${e.toString()}");
      return emit(HistorialEntregaFailed(error: e.toString()));
    }
  }

}
