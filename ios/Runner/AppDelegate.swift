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
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        switch call.method {
          case "removeSecure":
            self.window.removeSecure()
          default:
              result(nil)
        }
    })
    self.window.makeSecure()
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

//And this extension
extension UIWindow {
    func makeSecure() {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.tag = 4450 // Tambahkan tag untuk identifikasi nanti
        self.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.layer.superlayer?.addSublayer(field.layer)
        if #available(iOS 17.0, *) {
          field.layer.sublayers?.last?.addSublayer(self.layer)
        } else {
          field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
    
    func removeSecure() {
        if let field = self.viewWithTag(4450) as? UITextField {
            field.removeFromSuperview() // Menghapus UITextField dari UIWindow
        }
    }
}
