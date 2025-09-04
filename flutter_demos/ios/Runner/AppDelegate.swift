import Flutter
import UIKit
import gyges_logger
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GLLogger.print("Testing my logger.")
      let format = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) ?? ""
      let is24 = !format.contains("a")
      print("=== \(is24)")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
