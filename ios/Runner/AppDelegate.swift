import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.orbit.digilib", binaryMessenger: controller.binaryMessenger)
    startListening(for: channel)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  } 

  private func startListening(for channel: FlutterMethodChannel) {
    if #available(iOS 11.0, *) {
    NotificationCenter.default.addObserver(
        forName: UIScreen.capturedDidChangeNotification,
        object: nil,
        queue: .main
      ) { notification in
        let isCaptured = UIScreen.main.isCaptured
        channel.invokeMethod("onScreenRecordingChanged", arguments: isCaptured)
      }
    }
    
    NotificationCenter.default.addObserver(
        forName: UIApplication.userDidTakeScreenshotNotification,
        object: nil,
        queue: .main
    ) { notification in
        channel.invokeMethod("onScreenshotTaken", arguments: nil)
    }
  }
}