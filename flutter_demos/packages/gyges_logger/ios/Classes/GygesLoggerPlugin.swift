import Flutter
import UIKit

public class GygesLoggerPlugin: NSObject, FlutterPlugin {
    
    static var channel: FlutterMethodChannel?
    static var isDidSetFlutterMethodHandler = false
    static var tempLogs: [String] = []
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = GygesLoggerPlugin()
        channel = FlutterMethodChannel(name: "gyges_logger", binaryMessenger: registrar.messenger())
        guard let channel = channel else { return }
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "didSetFlutterMethodHandler":
            GygesLoggerPlugin.isDidSetFlutterMethodHandler = true
            GygesLoggerPlugin.savelogList(GygesLoggerPlugin.tempLogs);
            GygesLoggerPlugin.tempLogs.removeAll()
            result(true)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    static func log(_ message: String) {
        if (isDidSetFlutterMethodHandler) {
            savelogList([message])
        } else {
            tempLogs.append(message)
        }
    }
    
    static func savelogList(_ messages: [String]) {
        channel?.invokeMethod("print", arguments: messages)
    }
}

public class GLLogger {
    public static func print(_ mess: String) {
        GygesLoggerPlugin.log(mess)
    }
}
