import SwiftUI

struct LaunchScreen: View {
  @State private var isShownLoadingAnimation = true
  @EnvironmentObject var authService: AuthenticationService
  
  var body: some View {
    Group {
      switch authService.authState {
      case .signedIn(_):
        if isShownLoadingAnimation {
          loadingBackground()
        } else {
          TabBarView()
        }
      case .signedOut:
        LoginScreen()        
      case .loading:
        loadingBackground()
      case .error(let error):
        loadingBackground(error: error)
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        isShownLoadingAnimation = false
      }
    }
  }
  
  // MARK: - Subviews
  
  private func loadingBackground(error: Error? = nil) -> some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      VStack {
        HStack {
          Text("Launching app...")
          ProgressView()
        }
        if let error {
          Text(error.localizedDescription)
            .font(.footnote)
            .foregroundStyle(.red)
            .padding()
          Text("Relaunch the app to try again.")
            .font(.headline)
        }
      }
    }
  }
}
