import SwiftUI

struct SettingScreen: View {
  
  @State private var password: String = ""
  @State private var isShownDeletetionAlert = false
  @State private var isShownPasswordSheet = false
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea()
      List {
        ColorThemePickerView()
        LanguagePickerView()
        updateEmailCell
        deleteAccountCell
      }
      .customListStyle(rowHeight: 55, rowSpacing: 10, shadow: 1)
    }
    .sheet(isPresented: $isShownPasswordSheet) {
      passwordInputView
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
    .navigationTitle("settings_title")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private var passwordInputView: some View {
    VStack {
      Text("Input your account password.")
        .font(.callout)
      TextField("Password", text: $password)
        .textFieldStyle(.roundedBorder)
      Button("Delete Account") {
        Task {
          await authViewModel.deleteUser(withPassword: password)
          password = ""
        }
      }
      .disabled(password.isEmpty)
      .tint(.red)
      .buttonStyle(.bordered)
    }
  }
  
  private var updateEmailCell: some View {
    NavigationLink {
      UpdateEmailScreen()
    } label: {
      ListCell(for: .updateEmail)
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
}

#Preview {
  SettingScreen()
    .environmentObject(AuthViewModel.previewMode)
    .environmentObject(MapViewModel.previewMode)
}
