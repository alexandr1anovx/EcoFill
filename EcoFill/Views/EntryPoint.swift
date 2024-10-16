import SwiftUI

struct EntryPoint: View {
    
    @State private var isShownContent: Bool = false
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var stationVM: StationViewModel
    
    var body: some View {
        Group {
            if userVM.userSession != nil {
                if isShownContent {
                    TabView {
                        HomeScreen()
                            .tabItem { Label("Home", systemImage: "house") }
                        MapScreen()
                            .tabItem { Label("Map", systemImage: "map") }
                        ProfileScreen()
                            .tabItem { Label("Profile", systemImage: "person.fill")}
                    }
                } else {
                    LaunchView()
                }
            } else {
                SignInScreen()
            }
        }
        .onAppear {
            stationVM.getStations()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.bouncy) {
                    isShownContent.toggle()
                }
            }
        }
    }
}
