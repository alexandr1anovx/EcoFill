import SwiftUI
import StoreKit

struct SettingsScreen: View {
  
  @Binding var isShownTabBar: Bool
  @State private var accountPassword: String = ""
  @State private var isShownLogoutAlert = false
  @State private var isShownDeletetionAlert = false
  @State private var isShownPasswordSheet = false
  @Environment(\.requestReview) var requestReview
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea()
        List {
          Section("General") {
            ColorThemePickerView()
            AppLanguageView()
          }
          Section("Personal Data") {
            updatePersonalDataCell
          }
          Section("Additional") {
            rateUsCell
          }
          Section("Other") {
            aboutTheDeveloperCell
            logoutCell
            deleteAccountCell
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
  
  // MARK: - Components
  
  private var updatePersonalDataCell: some View {
    NavigationLink {
      ProfileScreen()
        .onAppear { isShownTabBar = false }
    } label: {
      ListCell(for: .updatePersonalData)
    }
  }
  
  private var rateUsCell: some View {
    Button {
      requestReview()
    } label: {
      ListCell(for: .rateUs)
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
  
  private var logoutCell: some View {
    Button {
      isShownLogoutAlert.toggle()
    } label: {
      ListCell(for: .logout)
    }
    .alert("logout_title", isPresented: $isShownLogoutAlert) {
      Button("logout_title", role: .destructive) {
        withAnimation(.easeInOut(duration: 1)) {
          authViewModel.signOut()
        }
      }
    } message: {
      Text("logout_alert_message")
    }
  }
  
  private var deleteAccountCell: some View {
    Button {
      isShownDeletetionAlert.toggle()
    } label: {
      ListCell(for: .deleteAccount)
    }
    .alert("delete_account_title", isPresented: $isShownDeletetionAlert) {
      Button("Delete", role: .destructive) {
        isShownPasswordSheet = true
      }
    } message: {
      Text("delete_account_subtitle")
    }
  }
  
  private var passwordInputView: some View {
    VStack {
      Text("Input your account password.")
        .font(.callout)
      TextField("Password", text: $accountPassword)
        .textFieldStyle(.roundedBorder)
      Button("Delete Account") {
        Task {
          await authViewModel.deleteUser(withPassword: accountPassword)
          accountPassword = ""
        }
      }
      .disabled(accountPassword.isEmpty)
      .tint(.red)
      .buttonStyle(.bordered)
    }
  }
}

#Preview {
  SettingsScreen(isShownTabBar: .constant(true))
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
}
