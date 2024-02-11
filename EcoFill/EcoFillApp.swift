//
//  EcoFillApp.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct EcoFillApp: App {
  
  // MARK: - Properties
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // Register app delegate for Firebase setup
  @AppStorage("userTheme") private var selectedTheme: Theme = .systemDefault
  @StateObject private var frbAuthViewModel = FirebaseAuthViewModel()
  
  var body: some Scene {
    WindowGroup {
      MainTabScreen()
        .environmentObject(frbAuthViewModel)
        .preferredColorScheme(selectedTheme.colorScheme)
    }
  }
}
