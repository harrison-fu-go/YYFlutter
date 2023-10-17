/*
 * third
 * Create by Harrison.Fu on 2023/10/17-11:00
 */

import 'package:demo1/third/third_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdPageState();
  }
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThirdBloc>(
        create: (context) => ThirdBloc(),
        child: BlocBuilder<ThirdBloc, ThirdState>(
            builder: (ctx, state) => Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "ThirdPage",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("==== car: ${state.carName}, price: ${state.price}"),
                    InkWell(onTap: () => {
                      ctx.read<ThirdBloc>().add(DoThirdEvent(ctx, "20"))
                    },
                      child: Container(padding: const EdgeInsets.only(top: 18),
                      color: Colors.red,
                      height: 50,
                        child:  Text("====Click====="),),
                    )],
                )))));
  }
}
