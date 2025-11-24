/*
 * second
 * Create by Harrison.Fu on 2023/10/16-16:03
 */

import 'package:demo1/second/second_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  void updateInfo(BuildContext ctx) {
    ctx.read<SecondCubit>().updateState(name: "张三", age: 29);
    Future.delayed(const Duration(seconds: 3), (){
      BlocProvider.of<SecondCubit>(ctx).updateState(name: "王5", age: 88);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SecondCubit>(
        create: (context) => SecondCubit(secondInitial: SecondInitial(name: "李四", age: 18)),
        child: BlocBuilder<SecondCubit, SecondInitial>(
            builder: (ctx, state) =>
                Scaffold(
                  appBar: AppBar(
                    title: Text(
                      state.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'age: ${state.age}',
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      updateInfo(ctx);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.update),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                )));
  }
}
