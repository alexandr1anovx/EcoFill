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
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          UserDataHeader()
          List {
            settingsButton
            rateUsButton
            signOutButton
          }
          .scrollContentBackground(.hidden)
          .scrollIndicators(.hidden)
          .listRowSpacing(10)
          .shadow(radius: 1)
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
      ListCell(
        title: "settings_title",
        subtitle: "settings_subtitle",
        icon: "gear",
        iconColor: .primaryLabel
      )
    }
  }
  
  private var rateUsButton: some View {
    Button {
      requestReview()
    } label: {
      ListCell(
        title: "rate_us_title",
        subtitle: "rate_us_subtitle",
        icon: "hand.thumbsup",
        iconColor: .orange
      )
    }
  }
  
  private var signOutButton: some View {
    Button {
      isShownAlert.toggle()
    } label: {
      ListCell(
        title: "sign_out_title",
        subtitle: "sign_out_subtitle",
        icon: "rectangle.portrait.and.arrow.right",
        iconColor: .red
      )
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
    .environmentObject(AuthViewModel())
    .environmentObject(MapViewModel())
}

