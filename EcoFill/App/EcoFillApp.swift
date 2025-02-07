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
  
  @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
  @StateObject private var userVM = UserViewModel()
  @StateObject private var stationVM = StationViewModel()
  
  var body: some Scene {
    WindowGroup {
      LaunchScreen()
        .preferredColorScheme(appColorScheme.colorScheme)
        .environmentObject(userVM)
        .environmentObject(stationVM)
        .onAppear {
          stationVM.getStations() // Get the stations data from the Firebase
        }
    }
  }
}
