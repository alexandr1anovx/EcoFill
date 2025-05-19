import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct EcoFillApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  @AppStorage("colorTheme") private var selectedColorTheme: ColorTheme = .system
  @StateObject private var authViewModel = AuthViewModel()
  @StateObject private var stationViewModel = StationViewModel()
  @StateObject private var mapViewModel = MapViewModel()
  
  var body: some Scene {
    WindowGroup {
      LaunchScreen()
        .preferredColorScheme(selectedColorTheme.colorTheme)
        .environmentObject(authViewModel)
        .environmentObject(stationViewModel)
        .environmentObject(mapViewModel)
    }
  }
}

