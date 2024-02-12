
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/entities/bono_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/get_bonos_usecase.dart';
import 'package:reciward_flutter_app/features/aprendiz/bono/domain/usecases/save_bono_aprendiz_usecase.dart';

part 'bono_event.dart';
part 'bono_state.dart';

class BonoBloc extends Bloc<BonoEvent, BonoState> {

  GetBonosUsecase usecase = GetIt.instance<GetBonosUsecase>();
  SaveBonoAprendizUsecase saveBonoAprendizUsecase = GetIt.instance<SaveBonoAprendizUsecase>();


  BonoBloc() : super(BonoInitial()) {
    on<GetBonosEvent>(onGetBonosEvent);

    on<SaveBonoAprendizEvent>(onSaveBonoAprendizEvent);
  }

  void onGetBonosEvent (GetBonosEvent event, Emitter<BonoState> emit) async{
    try {
      emit(GetBonosLoading());
      Either<DioException, List<BonoEntity>> either = await usecase.call(event.accessToken);
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
}
