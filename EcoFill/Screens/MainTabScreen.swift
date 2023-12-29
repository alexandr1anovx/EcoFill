//
//  ContentView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

struct MainTabScreen: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  var body: some View {
    Group {
      if authViewModel.userSession != nil {
        MainTabView()
      } else {
        SignInScreen()
      }
    }
  }
}

#Preview {
  MainTabScreen()
}

struct MainTabView: View {
  var body: some View {
    TabView {
      /// Home Screen
      HomeScreen()
        .tabItem {
          Label("Home",systemImage: "house")
        }
      
      /// Map Screen
      MapScreen()
        .tabItem {
          Label("Maps",systemImage: "map")
        }
      
      /// Profile Screen
      ProfileScreen()
        .tabItem {
          Label("Profile",systemImage: "person.fill")
        }
    }
  }
}
