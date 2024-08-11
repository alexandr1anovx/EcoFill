import SwiftUI

struct MainTabScreen: View {
    
    // MARK: - Public Properties
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    // MARK: - body
    var body: some View {
        Group {
            if authenticationViewModel.userSession != nil {
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
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
