import SwiftUI

struct LaunchScreen: View {
  
  @State private var isShownAppContent = false
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var stationVM: StationViewModel
  
  var body: some View {
    Group {
      if authViewModel.userSession != nil {
        if isShownAppContent {
          TabBarView()
        } else {
          loadingBackground
        }
      } else {
        LoginScreen()
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation(.spring(duration: 1)) {
          isShownAppContent.toggle()
        }
      }
    }
  }
  
  private var loadingBackground: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack {
        Image(.logo)
        HStack {
          Text("Launching...")
          ProgressView()
        }
      }
    }
  }
}

#Preview {
  LaunchScreen()
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
}
