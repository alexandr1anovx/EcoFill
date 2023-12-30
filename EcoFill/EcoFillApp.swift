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
  // Register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
  @StateObject private var authViewModel = AuthViewModel()
  
  var body: some Scene {
    WindowGroup {
      MainTabScreen()
        .environmentObject(authViewModel)
        .preferredColorScheme(userTheme.colorScheme)
    }
  }
}
