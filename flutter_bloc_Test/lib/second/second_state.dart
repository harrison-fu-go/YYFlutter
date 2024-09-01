part of 'second_cubit.dart';

@immutable
// abstract class SecondState {}

class SecondInitial { //extends SecondState {
  int age;

  String name;

  SecondInitial({required this.age, required this.name});

  SecondInitial clone() {
    return SecondInitial(age: age, name: name);
  }
}
