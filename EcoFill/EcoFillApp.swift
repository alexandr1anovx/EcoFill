//
//  EcoFillApp.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI
import FirebaseCore
import MapKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct EcoFillApp: App {
  
  // MARK: - Properties
  
  // Register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject private var authenticationVM = AuthenticationViewModel()
  @StateObject private var firestoreVM = FirestoreViewModel()
  @AppStorage("selectedScheme") private var selectedScheme: Scheme = .system

  var body: some Scene {
    WindowGroup {
      MainTabScreen()
        .environmentObject(authenticationVM)
        .environmentObject(firestoreVM)
        .preferredColorScheme(selectedScheme.colorScheme)
        .onAppear {
          firestoreVM.fetchStations()
        }
    }
  }
}
