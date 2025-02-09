import SwiftUI

struct LaunchScreen: View {
  
  @State private var isShownContent = false
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    Group {
      if userVM.userSession != nil {
        if isShownContent {
          TabBarView()
        } else {
          logoImageBackground
        }
      } else {
        SignInScreen()
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation(.spring(duration: 1)) {
          isShownContent.toggle()
        }
      }
    }
  }
  
  private var logoImageBackground: some View {
    ZStack {
      Color.primaryBackground.ignoresSafeArea(.all)
      Image("logo")
    }
  }
}
