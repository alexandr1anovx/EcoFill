import SwiftUI
import StoreKit

struct SettingsScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var accountPassword: String = ""
  @State private var isShownLogoutAlert = false
  @State private var isShownDeletetionAlert = false
  @State private var isShownPasswordSheet = false
  @Environment(\.requestReview) var requestReview
  
  @EnvironmentObject var sessionManager: SessionManager
  
  let firebaseAuthService: AuthServiceProtocol
  let firestoreUserService: UserServiceProtocol
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        List {
          Section("General") {
            ColorThemeSelectionView()
            ChangeAppLanguageView()
          }
          Section("Personal Data") {
            updatePersonalDataCell
          }
          Section("Additional") {
            rateUsCell
          }
          Section("Other") {
            aboutTheDeveloperCell
            //logoutCell
          }
        }
        .customListStyle(rowHeight: 52, rowSpacing: 10, shadow: 1)
        .navigationTitle(Tab.settings.title)
        .sheet(isPresented: $isShownPasswordSheet) {
          passwordInputView
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .onAppear { isShownTabBar = true }
      }
    }
  }
  
  // MARK: - Subviews
  
  private var updatePersonalDataCell: some View {
    NavigationLink {
      ProfileScreen(
        firebaseAuthService: firebaseAuthService,
        firestoreUserService: firestoreUserService,
        sessionManager: sessionManager
      )
        .onAppear { isShownTabBar = false }
    } label: {
      ListCell(for: .updatePersonalData)
    }
  }
  
  private var rateUsCell: some View {
    Button {
      requestReview()
    } label: {
      ListCell(for: .helpUsImprove)
    }
  }
  
  private var aboutTheDeveloperCell: some View {
    NavigationLink {
      AboutTheDeveloperScreen()
        .onAppear { isShownTabBar = false }
    } label: {
      ListCell(for: .aboutTheDeveloper)
    }
  }
  
//  private var logoutCell: some View {
//    Button {
//      isShownLogoutAlert.toggle()
//    } label: {
//      ListCell(for: .logout)
//    }
//    .alert("Log Out", isPresented: $isShownLogoutAlert) {
//      Button("Log Out", role: .destructive) {
//        Task { await viewModel.signOut() }
//      }
//    } message: {
//      Text("This action will redirect you to the login screen.")
//    }
//  }
  
  // MARK: ⚠️ Redesign This Part! ⚠️
  
  private var passwordInputView: some View {
    VStack {
      Text("Input your account password")
        .font(.callout)
      TextField("Password", text: $accountPassword)
        .textFieldStyle(.roundedBorder)
      Button("Delete Account") {
        /*
        Task {
          await authViewModel.deleteUser(withPassword: accountPassword)
          accountPassword = ""
        }
        */
      }
      .disabled(accountPassword.isEmpty)
      .tint(.red)
      .buttonStyle(.bordered)
    }
  }
}
