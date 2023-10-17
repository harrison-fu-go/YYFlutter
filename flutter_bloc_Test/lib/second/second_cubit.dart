import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'second_state.dart';

class SecondCubit extends Cubit<SecondInitial> {
  SecondCubit({required SecondInitial secondInitial}) : super(secondInitial);
  //update state
  void updateState({required String name, required int age}) {
    state.name = name;
    state.age = age;
    var newState = state.clone();
    emit(newState);
  }
}
