import SwiftUI

struct ProfileScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var isShownAlert = false
  @EnvironmentObject var userVM: UserViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        
        VStack {
          UserDataView()
          List {
            AppColorSchemeCell().listRowBackground(Color.primaryBackground)
            signOutButton
          }
          .listStyle(.plain)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ToolbarLogoImage()
          }
          ToolbarItem(placement: .topBarTrailing) {
            settingsButton
          }
        }
        .onAppear { isShownTabBar = true }
      }
    }
  }
  
  private var settingsButton: some View {
    NavigationLink {
      SettingScreen()
        .onAppear { isShownTabBar = false }
    } label: {
      Image("gear")
        .navigationBarImageSize
        .foregroundStyle(.accent)
    }
  }
  
  private var signOutButton: some View {
    PlainListCell(
      title: "Sign Out",
      description: "Sign out from current account.",
      image: "logout",
      imageColor: .primaryRed
    )
    .listRowBackground(Color.primaryBackground)
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
