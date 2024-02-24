//
//  ContentView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

struct MainTabScreen: View {
  
  // MARK: - Properties
  @EnvironmentObject var authenticationVM: AuthenticationViewModel
  
  var body: some View {
    Group {
      if authenticationVM.userSession != nil {
        MainTabView()
      } else {
        SignInScreen()
      }
    }
  }
}

struct MainTabView: View {
  var body: some View {
    TabView {
      HomeScreen()
        .tabItem {
          Label("Home",systemImage: "house")
        }
      MapScreen()
        .tabItem {
          Label("Map",systemImage: "map")
        }
      ProfileScreen()
        .tabItem {
          Label("Profile",systemImage: "person.fill")
        }
    }
  }
}
