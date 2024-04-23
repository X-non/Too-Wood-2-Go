import UIKit
import Flutter
import GoogleMaps
import flutter_config

// let googleMapsApiKey = flutter_config_plus.FlutterConfigPlusPlugin.env(for: "GOOGLE_MAPS_API_KEY")

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "GMP_KEY"))
    GeneratedPluginRegistrant.register(with: self)
    //GMSPlacesClient.provideAPIKey("googleMapsApiKey")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
