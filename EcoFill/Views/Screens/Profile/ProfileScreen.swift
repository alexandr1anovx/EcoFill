import SwiftUI



struct ProfileScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var isShownAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          UserDataHeader()
          List {
            ColorSchemeChanger()
            settingsButton
            rateUsButton
            signOutButton
          }
          .listStyle(.insetGrouped)
          .scrollContentBackground(.hidden)
          .scrollIndicators(.hidden)
          .listRowSpacing(10)
          .shadow(radius: 1)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
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
        icon: .settings,
        iconColor: .primaryReversed
      )
    }
  }
  
  private var rateUsButton: some View {
    ListCell(
      title: "Rate Us",
      subtitle: "Help more people to know about us.",
      icon: .like,
      iconColor: .orange
    )
  }
  
  private var signOutButton: some View {
    HStack(spacing: 15) {
      Image(.signOut)
        .foregroundStyle(.red)
      Text("Sign Out")
        .font(.system(size: 15))
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.primaryReversed)
        .padding(.vertical, 10)
    }
    .onTapGesture {
      isShownAlert.toggle()
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
