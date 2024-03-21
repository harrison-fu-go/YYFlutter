import Flutter
import UIKit

public class NativeDemoPlugin: NSObject, FlutterPlugin {
    
  public static func register(with registrar: FlutterPluginRegistrar) {
//    let channel = FlutterMethodChannel(name: "native_demo", binaryMessenger: registrar.messenger())
//    let instance = NativeDemoPlugin()
//    registrar.addMethodCallDelegate(instance, channel: channel)
      self.initMethodChannel(channel: "samples.flutter.dev/battery", registrar: registrar)
  }

//  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    switch call.method {
//    case "getPlatformVersion":
//      result("iOS " + UIDevice.current.systemVersion)
//    default:
//      result(FlutterMethodNotImplemented)
//    }
//  }
    
    public static func initMethodChannel(channel:String, registrar: FlutterPluginRegistrar) {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryChannel = FlutterMethodChannel(name: channel, binaryMessenger: registrar.messenger())
        batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "getBatteryLevel" else {
                result(FlutterMethodNotImplemented)
                return
            }
            print("========UIDevice.current.batteryLevel: \(UIDevice.current.batteryLevel)")
            result("Device battry: \(UIDevice.current.batteryLevel * 100.0)")
        })
    }
    
}
