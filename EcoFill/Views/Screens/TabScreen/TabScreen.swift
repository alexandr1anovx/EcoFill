import SwiftUI

struct TabScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isLaunchScreenShown = true
    
    var body: some View {
        ZStack {
            if isLaunchScreenShown {
                LaunchScreen()
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
                        UserScreen()
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
                    isLaunchScreenShown = false
                }
            }
        }
    }
}
