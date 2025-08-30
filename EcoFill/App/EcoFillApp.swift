import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    return true
  }
}

@main
struct EcoFillApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @AppStorage("colorScheme") private var appColorScheme: ColorTheme = .system
  
  @State private var sessionManager: SessionManager
  @State private var stationViewModel: StationViewModel
  @State private var mapViewModel = MapViewModel()
  
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  init() {
    // 1. First, configure Firebase.
    FirebaseApp.configure()
    
    // 2. When the Firebase is ready, create services (they depend on Firebase).
    let authService = AuthService()
    let userService = UserService()
    self.authService = authService
    self.userService = userService
    
    // 3. Create dependent objects by passing ready-made services.
    self._sessionManager = State(wrappedValue: SessionManager(userService: userService))
    self._stationViewModel = State(wrappedValue: StationViewModel())
  }
  
  var body: some Scene {
    WindowGroup {
      Group {
        switch sessionManager.state {
        case .loggedIn(_):
          TabBarView(authService: authService, userService: userService)
        case .loggedOut:
          LoginScreen(authService: authService, userService: userService)
        }
      }
      .animation(.easeInOut, value: sessionManager.state)
      .onAppear {
        Task {
          await stationViewModel.fetchStations()
        }
      }
      .preferredColorScheme(appColorScheme.colorScheme)
      .environment(sessionManager)
      .environment(stationViewModel)
      .environment(mapViewModel)
    }
  }
}
