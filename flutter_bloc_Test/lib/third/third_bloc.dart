import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'third_event.dart';
part 'third_state.dart';

class ThirdBloc extends Bloc<ThirdEvent, ThirdState> {
  ThirdBloc() : super(ThirdState()) {
    on<DoThirdEvent>((event, emit) {
      doSetCarInfo(event, emit);
    });
  }

  void doSetCarInfo(DoThirdEvent event, Emitter<ThirdState> emit) {
    if (event.code == "20") {
      state.carName = "奔驰";
      state.price = 2000000;
      emit(state.clone());
    }
  }
}


