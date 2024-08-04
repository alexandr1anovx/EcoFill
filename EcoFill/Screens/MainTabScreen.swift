//
//  ContentView.swift
//  EcoFill
//
//  Created by Alexander Andrianov on 29.11.2023.
//

import SwiftUI

struct MainTabScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationVM: AuthenticationViewModel
    
    // MARK: - body
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
                    Label("Home", systemImage: "house")
                }
            MapScreen()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            ProfileScreen()
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
        }
    }
}
