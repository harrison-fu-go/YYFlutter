
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'gyges_logger_db.dart';

class GLLogger {
  
  static final GLLogger shared = GLLogger();
  
  initBase() {
    WidgetsFlutterBinding.ensureInitialized();
    GLLoggerNative.instance.setCallHandler(handleMethodCall);
    GLLoggerNative.instance.didSetFlutterMethodHandler();
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'print':
        var arguments = call.arguments;
        if (arguments is List<Object?>) {
          for (Object? str in arguments) {
            if (str != null && str is String) {
              onReceiveLog(str);
            }
          }
        }
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "Flutter doesn't implement "
                "the method '${call.method}'");
    }
  }

  onReceiveLog(String mess) {
    GLLoggerDB.addALog(mess);
  }
}

class GLLoggerChannel extends GLLoggerNative {
  final methodChannel = const MethodChannel('gyges_logger');
  @override
  setCallHandler(Future<dynamic> Function(MethodCall call)? handler) {
    methodChannel.setMethodCallHandler(handler);
  }

  @override
  Future<bool?> didSetFlutterMethodHandler() async {
    // bool? version = await methodChannel.invokeMethod<bool>('didSetFlutterMethodHandler');
    // return version;
  }
}

abstract class GLLoggerNative extends PlatformInterface {
  GLLoggerNative() : super(token: _token);
  
  static final Object _token = Object();
  
  static GLLoggerNative _instance = GLLoggerChannel();
  
  static GLLoggerNative get instance => _instance;
  
  static set instance(GLLoggerNative instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  setCallHandler(Future<dynamic> Function(MethodCall call)? handler) {
    //throw UnimplementedError('setCallHandler() has not been implemented.');
  }

  Future<bool?> didSetFlutterMethodHandler() async{
    //throw UnimplementedError('didSetFlutterMethodHandler() has not been implemented.');
  }
}