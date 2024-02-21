
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/get_historial_bono.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bono_cafeteria_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bonos_historial.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bonos_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/save_bono_aprendiz_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/update_bono_cafeteria_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/validar_bono_usecase.dart';
import 'package:reciward_flutter_app/features/cafeteria/models/get_bono_cafeteria_dto.dart';

part 'bono_event.dart';
part 'bono_state.dart';

class BonoBloc extends Bloc<BonoEvent, BonoState> {

  GetBonosUsecase usecase = GetIt.instance<GetBonosUsecase>();
  SaveBonoAprendizUsecase saveBonoAprendizUsecase = GetIt.instance<SaveBonoAprendizUsecase>();
  GetBonosHistorialUsecase getBonosHistorialUsecase = GetIt.instance<GetBonosHistorialUsecase>();

  GetBonoCafeteriaUsecase getBonoCafeteriaUsecase = GetIt.instance<GetBonoCafeteriaUsecase>();

  ValidarBonoUsecase validarBonoUsecase = GetIt.instance<ValidarBonoUsecase>();

  UpdateBonoCafeteriaUsecase updateBonoCafeteriaUsecase = GetIt.instance<UpdateBonoCafeteriaUsecase>();

  BonoBloc() : super(BonoInitial()) {
    on<GetBonosEvent>(onGetBonosEvent);

    on<SaveBonoAprendizEvent>(onSaveBonoAprendizEvent);

    on<GetHistorialBonosEvent>(onGetHistorialBonosEvent);

    on<GetBonoCafeteriaEvent>(onGetBonoCafeteriaEvent);

    on<ValidarBonoEvent>(onValidarBonoEvent);

    on<UpdateBonoEvent>(onUpdateBonoEvent);
  }

  void onGetHistorialBonosEvent (GetHistorialBonosEvent event, Emitter<BonoState> emit) async {
    try {
      Either<DioException, List<GetHistorialBono>> either = await getBonosHistorialUsecase.call(event.accessToken);

      return either.fold((dio) => emit(GetHistorialBonosFailed(error: dio.message!)), (data) => emit(GetHistorialBonosSuccess(bonos: data)));
    } catch (e) {
      print("Error en onGetHistorialBonosEvent ${e.toString()}");
      return emit(GetHistorialBonosFailed(error: e.toString()));
    }
  }

  void onGetBonosEvent (GetBonosEvent event, Emitter<BonoState> emit) async{
    try {
      emit(GetBonosLoading());
      Either<DioException, List<BonoEntity>> either = await usecase.call(event.accessToken, event.rol);
      return either.fold((dio) => 
        emit(GetBonoFailedState(error: dio.message!)), 
      (data) =>
        emit(GetBonoSuccessState(bonos: data)) 
      );
    } catch (e) {
      print("Error en onGetBonosEvent ${e.toString()}");
      return emit(GetBonoFailedState(error: e.toString()));
    }
  }

  void onSaveBonoAprendizEvent (SaveBonoAprendizEvent event, Emitter<BonoState> emit) async {
    try {
      
      Either<DioException, String> either = await saveBonoAprendizUsecase.call(event.accessToken, event.bonoId);

      return either.fold((dio) => emit(SaveBonoAprendizFailed(error: dio.message!)), (message) => emit(SaveBonoAprendizSuccess(message: message, accessToken: event.accessToken)));

    } catch (e) {
      print("Error en onSaveBonoAprendizEvent ${e.toString()}");
      return emit(SaveBonoAprendizFailed(error: e.toString()));
    }
  }


  void onGetBonoCafeteriaEvent (GetBonoCafeteriaEvent event, Emitter<BonoState> emit) async {
    try {
      Either<DioException, GetBonoCafeteriaDto> either = await getBonoCafeteriaUsecase.call(event.accessToken, event.code);

      return either.fold((dio) => emit(GetBonoCafeteriaFailed(error: dio.message!)), 
      (data) {
        emit(GetBonoCafeteriaSuccess(data: data));
      });
    } catch (e) {
      print("Error en onSaveBonoAprendizEvent ${e.toString()}");
      return emit(GetBonoCafeteriaFailed(error: e.toString()));
    }
  }

  void onValidarBonoEvent (ValidarBonoEvent event, Emitter<BonoState> emit) async{
    try {
      Either<DioException, String> either = await validarBonoUsecase.call(event.accessToken, event.idBono);
      return either.fold((dio) => emit(ValidarBonoFailed(error: dio.message!)), 
      (message) {
        emit(ValidarBonoSuccess(message: message));
      });
    } catch (e) {
      print("Error en onValidarBonoEvent ${e.toString()}");
      return emit(ValidarBonoFailed(error: e.toString()));
    }
  }

  void onUpdateBonoEvent (UpdateBonoEvent event, Emitter<BonoState> emit)async{
    try {
      Either<DioException, String> either = await updateBonoCafeteriaUsecase.call(event.accessToken, event.bonoEntity);
      return either.fold((dio) => emit(UpdateBonoFailed(error: dio.message!)), 
      (message) {
        emit(UpdateBonoSuccess(message: message));
      });
    } catch (e) {
      print("Error en onUpdateBonoEvent ${e.toString()}");
      return emit(UpdateBonoFailed(error: e.toString()));
    }
  }

}
