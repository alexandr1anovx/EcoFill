import SwiftUI

struct LaunchScreen: View {
  @State private var isShownLoadingAnimation = true
  @EnvironmentObject var authService: AuthenticationService
  @EnvironmentObject var userService: UserService
  
  var body: some View {
    Group {
      switch authService.authState {
      case .signedIn(_):
        if isShownLoadingAnimation {
          loadingBackground
        } else {
          TabBarView()
        }
      case .signedOut:
        LoginScreen()        
      case .loading:
        loadingBackground
      case .error(let error):
        Text("Loading Error: \(error.localizedDescription)")
          .foregroundColor(.red)
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation(.spring) {
          self.isShownLoadingAnimation = false
        }
      }
    }
  }
  
  // MARK: - Subviews
  
  private var loadingBackground: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack {
        Image(.logo)
        HStack {
          Text("Launching app...")
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
