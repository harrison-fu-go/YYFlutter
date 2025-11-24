/*
 * BasePage
 * Create by Harrison.Fu on 2024/1/9-11:20
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futter_engine_group_moudle/PrintTool.dart';
import 'package:futter_engine_group_moudle/navigate.dart';
import 'package:hello/hello.dart';
import 'package:native_demo/native_demo.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaseApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoPage(title: 'Base APP'),
    );
  }
}

class BaseApp1 extends StatelessWidget {
  const BaseApp1({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BaseApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoPage(title: 'Base APP'),
    );
  }
}


class DemoPage extends BasePage {
  const DemoPage({super.key, required super.title});
  @override
  State<BasePage> createState() => _DemoPageState();
}

class _DemoPageState extends BaseState {
  int _counter = 0;
  String _batteryLevel = 'Unknown battery level.';
  @override
  void didInitNavigateParam() {
    super.didInitNavigateParam();
    String? initCounter = initParam as String?;
    xDebugPrint(" ======= initCounter: $initCounter");
    if (initCounter != null) {
      setState(() {
        _counter = int.parse(initCounter);
      });
    }
  }

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    // var version = NativeDemo().getPlatformVersion();
    // print("========== \(version)");
    _getBatteryLevel();
  }

  // Get battery level.
  static const batteryMethodChannel = MethodChannel("samples.flutter.dev/battery");
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final String result = await batteryMethodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = result;//'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var finalVal = Calculator1().addTwo(10);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed times====: ',
            ),
            Text(
              '$finalVal=======$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            Text(
              _batteryLevel,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//========================================================================================================================================
/*
 * Base page for all page, all of the page should use this page as the base,
 * if the page have init parameters from native.
 */
class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.title});
  final String title;
  @override
  State<BasePage> createState() => BaseState();
}

class BaseState extends State<BasePage> {//DataSingle.count;
  var baseChannel = const BasicMessageChannel(kBaseNavigateParam, StandardMessageCodec());
  Object? initParam;
  String? pageIdentifier;
  @override
  void initState() {
    initNavigateParam();
    super.initState();
  }

  /*
  **Init state's navigation parameters.
  **base init
  */
  void initNavigateParam() async {
    var initParamMap = await baseChannel.send(kBaseNavigateInitParam) as Map?;
    if (initParamMap != null && initParamMap[kBaseNavigateInitParam] != null) {
      initParam = initParamMap[kBaseNavigateInitParam];
      pageIdentifier = initParamMap[kBaseNavigateChannelIdentifier] as String?;
      xDebugPrint("======= init navigate parameters: $initParam, identifier:$pageIdentifier");
    }
    didInitNavigateParam();
  }

  /*
  * this method means the init parameters had been initiated
  * */
  void didInitNavigateParam() { }

  /*
  * sub state should override this method, for render the new UI.
   */
  @override
  Widget build(BuildContext context) {
    return Text(widget.title);
  }

  @override
  void dispose() {
    super.dispose();
    print("=== page dispose $this");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print("=== page deactivate $this");
    super.deactivate();
  }
}
