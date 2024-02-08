import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/material/domain/entities/material_entity.dart';
import 'package:reciward_flutter_app/features/material/domain/usecases/get_materiales_usecase.dart';

part 'material_event.dart';
part 'material_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialesState> {

  GetMaterialesUsecase usecase = GetIt.instance<GetMaterialesUsecase>();

  MaterialBloc() : super(MaterialInitial()) {
    on<GetMaterialesEvent>(onGetMaterialEvent);
  }

  void onGetMaterialEvent(GetMaterialesEvent event, Emitter<MaterialesState> emit) async {
    try {
      emit(GetMaterialLoading());
      Either<DioException, List<MaterialEntity>> either = await usecase.call(event.accessToken, event.rol);
      return either.fold((dioException) {
        emit(GetMaterialFailed(error: dioException.message!));
      }, (data) {
        emit(GetMaterialSuccess(materiales: data));
      });
      
    } catch (e) {
      print("Error en onGetMaterialEvent $e");
      emit(GetMaterialFailed(error: e.toString()));
    }
  }
}
