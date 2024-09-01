/*
 * home_page
 * Create by Harrison.Fu on 2024/8/26-15:47
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/navigate.dart';
import 'models.dart';

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Button tapped:',
            ),
            // 使用Consumer来访问共享状态
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.count}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Consumer<ChangeModelTwo>(
              builder: (context, model, child) => Text(
                '${model.name}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Text("${context.read<Counter>().count}"),
            Text("${context.read<ChangeModelOne>().count}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 使用Provider来更新共享状态
          Provider.of<Counter>(context, listen: false).increment();
          Provider.of<ChangeModelTwo>(context, listen: false).name = "oooo===";
          Provider.of<ChangeModelOne>(context, listen: false).setCount(111);
          Presenter.push(context, NavigateRoute.one);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
