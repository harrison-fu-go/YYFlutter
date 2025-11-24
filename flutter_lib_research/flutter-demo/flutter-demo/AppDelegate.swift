//
//  AppDelegate.swift
//  flutter-demo
//
//  Created by HarrisonFu on 2023/10/20.
//

import UIKit
import Flutter

//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//    lazy var flutterEngine = FlutterEngine(name: "flutter engine")
//    override func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//
//        let result = super.application(application, didFinishLaunchingWithOptions: launchOptions)
//        flutterEngine.run()
//        debugPrint("===== flutter engin: \(flutterEngine.run())")
//        return result
//    }
//}
//

@UIApplicationMain
class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine")
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run()
    // Connects plugins with iOS platform code to this app.
//    GeneratedPluginRegistrant.register(with: self.flutterEngine);
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
