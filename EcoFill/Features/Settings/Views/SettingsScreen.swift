import SwiftUI

struct SettingsScreen: View {
  @Environment(SessionManager.self) var sessionManager
  @Binding var showTabBar: Bool
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  var body: some View {
    NavigationStack {
      Form {
        Section("General") {
          ColorThemeSelectionView()
          ChangeAppLanguageView()
        }
        Section("Personal Data") {
          NavigationLink {
            ProfileScreen(authService: authService, userService: userService)
          } label: {
            Text("Settings")
              .foregroundStyle(.black)
          }
        }
        Section("Other") {
          aboutTheDeveloperCell
        }
      }
      .navigationTitle(Tab.settings.title)
      .onAppear { showTabBar = true }
    }
  }
  
  // MARK: - Subviews
  
  private var aboutTheDeveloperCell: some View {
    NavigationLink {
      AboutTheDeveloperScreen()
        .onAppear { showTabBar = false }
    } label: {
      ListCell(for: .aboutTheDeveloper)
    }
  }
}

#Preview {
  SettingsScreen(
    showTabBar: .constant(false),
    authService: AuthService(),
    userService: UserService()
  )
  .environment(SessionManager.mockObject)
}
