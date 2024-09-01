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
    @AppStorage("preferredScheme") private var preferredScheme: Scheme = .system
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabScreen()
                .preferredColorScheme(preferredScheme.colorScheme)
                .environmentObject(userViewModel)
                .environmentObject(mapViewModel)
                .onAppear {
                    mapViewModel.getStations()
                }
        }
    }
}
