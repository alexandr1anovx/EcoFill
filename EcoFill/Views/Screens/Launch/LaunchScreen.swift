import SwiftUI

struct LaunchScreen: View {
  @State private var isShownContent = false
  @EnvironmentObject var userVM: UserViewModel
  @EnvironmentObject var stationVM: StationViewModel
  
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
      stationVM.getStations()
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation(.spring(duration: 1)) {
          isShownContent.toggle()
        }
      }
    }
  }
  
  private var logoImageBackground: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      Image(.logo)
    }
  }
}

#Preview {
  LaunchScreen()
    .environmentObject(UserViewModel())
    .environmentObject(StationViewModel())
}
