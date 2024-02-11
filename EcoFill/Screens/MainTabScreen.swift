//
//  ContentView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

struct MainTabScreen: View {
  @EnvironmentObject var frbAuthViewModel: FirebaseAuthViewModel
  var body: some View {
    Group {
      if frbAuthViewModel.userSession != nil {
        MainTabView()
      } else {
        SignInScreen()
      }
    }
  }
}

#Preview {
  MainTabScreen()
    .environmentObject(FirebaseAuthViewModel())
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
