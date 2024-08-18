import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller = window?.rootViewController as! FlutterViewController
    
    let methodChannel = FlutterMethodChannel(name: "screenshot_screenrecord_channel", binaryMessenger: controller.binaryMessenger)
    
    // Mendeteksi tangkapan layar
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(userDidTakeScreenshot),
        name: UIApplication.userDidTakeScreenshotNotification,
        object: nil
    )
    
    // Mendeteksi perekaman layar
    let screen = UIScreen.main
    screen.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  @objc func userDidTakeScreenshot() {
    // Kirim notifikasi ke Flutter ketika screenshot diambil
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ScreenshotTaken"), object: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "captured" {
      let screen = UIScreen.main
      if screen.isCaptured {
        // Kirim notifikasi ke Flutter ketika perekaman layar dimulai
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ScreenRecordingStarted"), object: nil)
      } else {
        // Kirim notifikasi ke Flutter ketika perekaman layar dihentikan
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ScreenRecordingStopped"), object: nil)
      }
    }
  }
}
