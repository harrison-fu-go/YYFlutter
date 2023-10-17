part of 'third_bloc.dart';

class ThirdState {
  String? carName;
  int? price;

  ThirdState clone() {
    return ThirdState()
      ..carName = carName
      ..price = price;
  }
}
