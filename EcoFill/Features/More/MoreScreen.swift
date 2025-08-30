import SwiftUI

struct MoreScreen: View {
  @Environment(SessionManager.self) var sessionManager
  @Binding var showTabBar: Bool
  @State private var showSignOutAlert = false
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  
  var body: some View {
    NavigationStack {
      Form {
        NavigationLink {
          SettingsScreen(authService: authService, userService: userService)
            .onAppear { showTabBar = false }
        } label: {
          Text("Settings")
        }
        Button("Sign Out") {
          signOut()
        }
        .tint(.red)
      }
      .listRowSpacing(8)
      .onAppear {
        showTabBar = true
      }
      .sheet(isPresented: $showSignOutAlert) {
        Text("Sign Out")
      }
    }
  }
}

// MARK: - Additional Methods
private extension MoreScreen {
  func signOut() {
    do {
      try authService.signOut()
    } catch {
      print("Failed to sign out: \(error)")
    }
  }
}

#Preview {
  MoreScreen(
    showTabBar: .constant(false),
    authService: AuthService(),
    userService: UserService()
  )
  .environment(SessionManager.mockObject)
}
