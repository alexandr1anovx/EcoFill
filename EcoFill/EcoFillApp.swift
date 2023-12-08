//
//  EcoFillApp.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

@main
struct EcoFillApp: App {
  @StateObject private var userViewModel = UserViewModel()
  var body: some Scene {
    WindowGroup {
      MainTabScreen()
        .environmentObject(userViewModel)
        .onAppear {
          userViewModel.retrieveUser()
        }
    }
  }
}
