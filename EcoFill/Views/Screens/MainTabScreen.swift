//import SwiftUI
//
//struct MainTabScreen: View {
//    @EnvironmentObject var userViewModel: UserViewModel
//    
//    var body: some View {
//        if userViewModel.userSession != nil {
//            TabView {
//                HomeScreen()
//                    .tabItem {
//                        Label("Home", systemImage: "house")
//                    }
//                MapScreen()
//                    .tabItem {
//                        Label("Map", systemImage: "map")
//                    }
//                ProfileScreen()
//                    .tabItem {
//                        Label("Profile", systemImage: "person.fill")
//                    }
//            }
//        } else {
//            SignInScreen()
//        }
//    }
//}

import SwiftUI

struct MainTabScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showSplash = true
    
    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
            } else {
                if userViewModel.userSession != nil {
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
                                Label("Profile", systemImage: "person.fill")
                            }
                    }
                } else {
                    SignInScreen()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(.logo)
                .resizable()
                .frame(width: 250, height: 250)
        }
    }
}
