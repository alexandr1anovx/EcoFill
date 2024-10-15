import SwiftUI

struct EntryPoint: View {
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var stationVM: StationViewModel
    @State private var isPresentedLaunchView = true
    
    var body: some View {
        Group {
            if isPresentedLaunchView {
                LaunchView()
            } else if userVM.userSession != nil {
                TabView {
                    HomeScreen()
                        .tabItem { Label("Home", systemImage: "house") }
                    MapScreen()
                        .tabItem { Label("Map", systemImage: "map") }
                    ProfileScreen()
                        .tabItem { Label("Profile", systemImage: "person.fill")}
                }
            } else {
                SignInScreen()
            }
        }
        .onAppear {
            stationVM.getStations()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isPresentedLaunchView = false
            }
        }
    }
}
