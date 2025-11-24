part of 'third_bloc.dart';

@immutable
abstract class ThirdEvent {}

class DoThirdEvent extends ThirdEvent {
  final BuildContext context;
  final String code;
  DoThirdEvent(this.context, this.code);
}