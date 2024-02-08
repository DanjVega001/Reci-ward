part of 'tip_bloc.dart';

sealed class TipEvent {}

class GetTips extends TipEvent {
  final String accessToken;

  GetTips({required this.accessToken});
}
