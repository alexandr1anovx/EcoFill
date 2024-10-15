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
    
    @AppStorage("appScheme") private var appScheme: Scheme = .system
    @StateObject private var userVM = UserViewModel()
    @StateObject private var stationVM = StationViewModel()
    
    var body: some Scene {
        WindowGroup {
            EntryPoint()
                .preferredColorScheme(appScheme.colorScheme)
                .environmentObject(userVM)
                .environmentObject(stationVM)
        }
    }
}
