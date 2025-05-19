import SwiftUI
import StoreKit

struct ProfileScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var isShownAlert = false
  @Environment(\.requestReview) var requestReview
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        VStack(spacing:0) {
          UserDataHeader()
          List {
            settingsButton
            rateUsButton
            signOutButton
          }
          .customListStyle(rowSpacing: 10, shadow: 1.0)
        }
        .navigationTitle("Profile")
        .onAppear { isShownTabBar = true }
      }
    }
  }
  
  private var settingsButton: some View {
    NavigationLink {
      SettingScreen()
        .onAppear { isShownTabBar = false }
    } label: {
      ListCell(for: .settings)
    }
  }
  
  private var rateUsButton: some View {
    Button {
      requestReview()
    } label: {
      ListCell(for: .rateUs)
    }
  }
  
  private var signOutButton: some View {
    Button {
      isShownAlert.toggle()
    } label: {
      ListCell(for: .signOut)
    }
    .alert("sign_out_subtitle", isPresented: $isShownAlert) {
      Button("sign_out_title", role: .destructive) {
        withAnimation(.easeInOut(duration: 1)) {
          authViewModel.signOut()
        }
      }
    } message: {
      Text("sign_out_alert_message")
    }
  }
}

#Preview {
  ProfileScreen(isShownTabBar: .constant(false))
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
}
