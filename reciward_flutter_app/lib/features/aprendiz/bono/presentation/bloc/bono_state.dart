part of 'bono_bloc.dart';

sealed class BonoState {}

final class BonoInitial extends BonoState {}

final class GetBonoSuccessState extends BonoState {
  final List<BonoEntity> bonos;

  GetBonoSuccessState({required this.bonos});
}

final class GetBonoFailedState extends BonoState {
  final String error;

  GetBonoFailedState({required this.error});
}

final class GetBonosLoading extends BonoState {}

final class SaveBonoAprendizSuccess extends BonoState {
  final String message;
  final String accessToken;

  SaveBonoAprendizSuccess({required this.message, required this.accessToken});
}

final class SaveBonoAprendizFailed extends BonoState {
  final String error;

  SaveBonoAprendizFailed({required this.error});
}

final class GetHistorialBonosSuccess extends BonoState {
  final List<GetHistorialBono> bonos;

  GetHistorialBonosSuccess({required this.bonos});
}

final class GetHistorialBonosFailed extends BonoState {
  final String error;

  GetHistorialBonosFailed({required this.error});
}
