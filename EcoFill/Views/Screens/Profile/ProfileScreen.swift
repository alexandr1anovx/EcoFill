import SwiftUI
import StoreKit

struct ProfileScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var isShownAlert = false
  @Environment(\.requestReview) var requestReview
  @EnvironmentObject var userVM: UserViewModel
  
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
        title: "Settings",
        subtitle: "Change your personal data.",
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
        title: "Rate Us",
        subtitle: "Help more people to know about us.",
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
        title: "Log Out",
        subtitle: "Securely sign out of your account.",
        icon: "rectangle.portrait.and.arrow.right",
        iconColor: .red
      )
    }
    .alert("Sign Out", isPresented: $isShownAlert) {
      Button("Sign Out", role: .destructive) {
        withAnimation(.easeInOut(duration: 1)) {
          userVM.signOut()
        }
      }
    } message: {
      Text("This action will redirect you to the Sign In screen.")
    }
  }
}

#Preview {
  ProfileScreen(isShownTabBar: .constant(false))
    .environmentObject(UserViewModel())
    .environmentObject(StationViewModel())
}
