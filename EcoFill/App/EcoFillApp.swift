import SwiftUI
import FirebaseCore
import FirebaseFirestore

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
  @AppStorage("colorTheme") private var selectedColorTheme: ColorTheme = .system
  
  @StateObject private var stationViewModel = StationViewModel()
  @StateObject private var mapViewModel = MapViewModel()
  @StateObject private var sessionManager: SessionManager
  
  private let firebaseAuthService: AuthServiceProtocol
  private let firestoreUserService: UserServiceProtocol
  
  init() {
    FirebaseApp.configure()
    let firebaseAuthService = FirebaseAuthService()
    let firestoreUserService = FirestoreUserService()
    self.firebaseAuthService = firebaseAuthService
    self.firestoreUserService = firestoreUserService
    _sessionManager = StateObject(
      wrappedValue: SessionManager(firestoreUserService: firestoreUserService)
    )
  }
  
  var body: some Scene {
    WindowGroup {
      RootView(
        sessionManager: sessionManager,
        firebaseAuthService: firebaseAuthService,
        firestoreUserService: firestoreUserService
      )
      .preferredColorScheme(selectedColorTheme.colorTheme)
      .environmentObject(stationViewModel)
      .environmentObject(mapViewModel)
      .environmentObject(sessionManager)
      .environmentObject(
        RegistrationViewModel(
          firebaseAuthService: firebaseAuthService,
          firestoreUserService: firestoreUserService
        )
      )
    }
  }
}
