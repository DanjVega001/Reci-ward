import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/entities/tip_entity.dart';
import 'package:reciward_flutter_app/features/aprendiz/tips/domain/usecase/get_tips_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final GetTipsUsecase getTipsUsecase = GetIt.instance<GetTipsUsecase>();
  TipBloc() : super(TipInitial()) {
    on<GetTips>(onGetTips);
  }

  void onGetTips(GetTips event, Emitter<TipState> emit) async {
    try {
      Either<DioException, List<TipEntity>> either =
          await getTipsUsecase.getTip(event.accessToken);
      return either.fold(
          (dioException) => emit(GetTipFailure(error: dioException.message!)),
          (data) => emit(GetTipSuccess(datos: data)));
    } catch (e) {
      print("Error in get tips event: $e");
      emit(GetTipFailure(error: e.toString()));
    }
  }
}
